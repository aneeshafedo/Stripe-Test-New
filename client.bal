import ballerina/http;
import ballerina/url;
import ballerina/mime;
import ballerina/io;

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
public type ClientConfig record {|
    # Configurations related to client authentication
    http:BearerTokenConfig|http:CredentialsConfig auth;
    # The HTTP version understood by the client
    string httpVersion = "1.1";
    # Configurations related to HTTP/1.x protocol
    http:ClientHttp1Settings http1Settings = {};
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings = {};
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with Redirection
    http:FollowRedirects? followRedirects = ();
    # Configurations associated with request pooling
    http:PoolConfiguration? poolConfig = ();
    # HTTP caching related configurations
    http:CacheConfig cache = {};
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig? circuitBreaker = ();
    # Configurations associated with retrying
    http:RetryConfig? retryConfig = ();
    # Configurations associated with cookies
    http:CookieConfig? cookieConfig = ();
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits = {};
    # SSL/TLS-related options
    http:ClientSecureSocket? secureSocket = ();
|};

# The Stripe REST API. Please see https://stripe.com/docs/api for more details.
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + clientConfig - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ClientConfig clientConfig, string serviceUrl = "https://api.stripe.com/") returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
    }

    remote isolated function getCustomers(Created? created = (), string? email = (), string? endingBefore = (), string[]? expand = (), int? 'limit = (), string? startingAfter = ()) returns InlineResponse2008|error {
        string  path = string `/v1/customers`;
        map<anydata> queryParam = {"email": email, "ending_before": endingBefore, "expand": expand, "limit": 'limit, "starting_after": startingAfter};
        if (created is CreatedObject) {
            queryParam["created[gt]"] = created?.gt;
            queryParam["created[gte]"] = created?.gte;
            queryParam["created[lt]"] = created?.lt;
            queryParam["created[lte]"] = created?.lte;
        } else {
            queryParam["created"] = created;
        }
        path = path + check getPathForQueryParam(queryParam);
        io:println("Path : " + path);
        InlineResponse2008 response = check self.clientEp-> get(path, targetType = InlineResponse2008);
        return response;
    }

    remote isolated function postCustomersCustomer(string customer, CustomersCustomerBody payload) returns Customer|error {
        string  path = string `/v1/customers/${customer}`;
        http:Request request = new;
        map<[string, boolean][]> encodingMap = {"deepObject" : [["address", true], ["bank_account", true], ["card", true], ["expand", true], ["invoice_settings", true], ["metadata", true], ["preferred_locales", true], ["shipping", true], ["tax", true], ["trial_end", true]]};
        string requestBody = createFormURLEncodedRequestBody(encodingMap, payload); 
        request.setTextPayload(requestBody);
        check request.setContentType(mime:APPLICATION_FORM_URLENCODED);
        Customer response = check self.clientEp->post(path, request, targetType=Customer);
        return response;
    }
}


isolated function createFormURLEncodedRequestBody(map<[string, boolean][]> encoding, any anyRecord) returns string{ 
    string payload = "";
    [string, boolean][]|error deepObjectStyleProps = trap encoding.get("deepObject");                
    [string, boolean][]|error formStyleProps = trap encoding.get("form");
    if (anyRecord is record {|any|error...; |}) {
        foreach [string, any|error] [key, value] in anyRecord.entries() {
            if (value is string|boolean|int|float) {
                payload = payload + key + "=" + getEncodedUri(value.toString()) + "&"; 
            } else if (value is string[]) {
                foreach var str in value {
                    payload = payload + key + "[]" + "=" + getEncodedUri(str.toString()) + "&";
                } 
            } else if (value is record {}) {
                if (deepObjectStyleProps is [string, boolean][] && deepObjectStyleProps.indexOf([key, true]) is int) {
                    payload = payload + getDeepObjectStyleRequestBody(key, value);
                } else { 
                    payload = payload + getFormStyleRequestBody(key, value, formStyleProps);
                }
            } else if (value is record {}[]) {
                int count = 0;
                foreach var recordItem in value {
                if (deepObjectStyleProps is [string, boolean][] && deepObjectStyleProps.indexOf([key, true]) is int) {
                        payload = payload + getDeepObjectStyleRequestBody(key + "[" + count.toString() + "]", value);
                    } else { 
                        payload = payload + getFormStyleRequestBody(key, value, formStyleProps);
                    }
                }
            }
        
        }
    }
    return payload;
}

isolated function getDeepObjectStyleRequestBody(string parent, any anyRecord) returns string{
    string recordString = "";
    if (anyRecord is record {|any|error...; |}) { 
        foreach [string, any|error] [key, value] in anyRecord.entries() {
            if (value is string|boolean|int|float) {
                recordString = recordString + parent + "[" + key + "]" + "=" + getEncodedUri(value.toString()) + "&";
            } else if (value is string[]) {
                foreach string str in value {
                    recordString = recordString + parent + "[" + key + "]" + "[]" + "=" + getEncodedUri(value.toString()) + "&";
                } 
            } else if (value is record {}) { // need to test. Couldnt find any reference for url-encoding nested records
                string nextParent = parent + "[" + key + "]";
                recordString = recordString + getDeepObjectStyleRequestBody(nextParent, value);
            } //need to imple record array. Couldnt find any reference
        }
    }
    
    return recordString;
}

isolated function getFormStyleRequestBody(string parent, any anyRecord, [string, boolean][]|error formStyleProps) returns string{
    string recordString = "";
    if (anyRecord is record {|any|error...; |}) { 
        if (formStyleProps is [string, boolean][] && formStyleProps.indexOf([parent, true]) is int) {
            foreach [string, any|error] [key, value] in anyRecord.entries() {
                if (value is string|boolean|int|float) {
                        recordString = recordString + key + "=" + getEncodedUri(value.toString()) + "&";
                } else if (value is string[]) {
                    foreach string str in value {
                        recordString = recordString + key + "=" + getEncodedUri(value.toString()) + "&";
                    } 
                } else if (value is record {}) { // need to test. Couldnt find any reference for url-encoding nested records
                    recordString = recordString + getFormStyleRequestBody(parent, value, formStyleProps);
                }
            }
        } else {
            recordString = recordString + parent+ "=";
            foreach [string, any|error] [key, value] in anyRecord.entries() {
                if (value is string|boolean|int|float) {
                    recordString = recordString + getEncodedUri(value.toString()) + ",";
                } else if (value is string[]) {
                    foreach string str in value {
                        recordString = recordString + getEncodedUri(value.toString()) + ",";
                    } 
                } else if (value is record {}) { // need to test. Couldnt find any reference for url-encoding nested records
                    recordString = recordString + getFormStyleRequestBody(parent, value, formStyleProps);
                } //need to imple record array. Couldnt find any reference
            }
        }
    }
    return recordString;
}

isolated function getEncodedUri(string value) returns string {
    string|error encoded = url:encode(value, "UTF8");
    if (encoded is string) {
        return encoded;
    } else {
        return value;
    }
}

# Generate query path with query parameter.
#
# + queryParam - Query parameter map 
# + return - Returns generated Path or error at failure of client initialization 
isolated function  getPathForQueryParam(map<anydata> queryParam)  returns  string|error {
    string[] param = [];
    param[param.length()] = "?";
    foreach  var [key, value] in  queryParam.entries() {
        if  value  is  () {
            _ = queryParam.remove(key);
        } else {
            if  string:startsWith( key, "'") {
                 param[param.length()] = string:substring(key, 1, key.length());
            } else {
                param[param.length()] = key;
            }
            param[param.length()] = "=";
            if  value  is  string {
                string updateV =  check url:encode(value, "UTF-8");
                param[param.length()] = updateV;
            } else {
                param[param.length()] = value.toString();
            }
            param[param.length()] = "&";
        }
    }
    _ = param.remove(param.length()-1);
    if  param.length() ==  1 {
        _ = param.remove(0);
    }
    string restOfPath = string:'join("", ...param);
    return restOfPath;
}
