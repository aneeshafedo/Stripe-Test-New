import ballerina/test;
import ballerina/http;
import ballerina/io;

configurable http:BearerTokenConfig & readonly authConfig = ?;
ClientConfig clientConfig = {auth : authConfig};
Client baseClient = check new Client(clientConfig, serviceUrl = "https://api.stripe.com");


@test:Config {}
function testGetCustomers() returns error? {
    Created createdObj = {
        gt: 1628828960,
        lte: 1628828972
    };
    InlineResponse2008 allCustomers = check baseClient->getCustomers(created = createdObj);
    io:println(allCustomers);
}

@test:Config {}
function testCreateCustomer() returns error? {
    CustomersCustomerBody newCustomer = {
        address: {
            city: "Colombo",
            country: "Sri Lanka"
        },
        balance: 200,
        email: "aneeshax@gmail.com"
    };
    Customer postCustomersCustomer = check baseClient->postCustomersCustomer("cus_K1vt95o2PvFn4R", newCustomer);
    io:println(postCustomersCustomer);
    
}