public type CreatedObject record {
    int gt?;
    int gte?;
    int lt?;
    int lte?;
};

public type  Created CreatedObject|int;

public type InlineResponse2008 record {
    Customer[] data;
    # True if this list has another page of items after this one that can be fetched.
    boolean? has_more;
    # String representing the object's type. Objects of the same type share the same value. Always has the value `list`.
    string? 'object;
    # The URL where this list can be accessed.
    string? url;
};

# `Customer` objects allow you to perform recurring charges, and to track
# multiple charges, that are associated with the same customer. The API allows
# you to create, delete, and update your customers. You can retrieve individual
# customers as well as a list of all your customers.
# 
# Related guide: [Save a card during payment](https://stripe.com/docs/payments/save-during-payment).
public type Customer record {
    # The customer's address.
    Address? address?;
    # Current balance, if any, being stored on the customer. If negative, the customer has credit to apply to their next invoice. If positive, the customer has an amount owed that will be added to their next invoice. The balance does not refer to any unpaid invoices; it solely takes into account amounts that have yet to be successfully applied to any invoice. This balance is only taken into account as invoices are finalized.
    int? balance?;
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    int? created;
    # Three-letter [ISO code for the currency](https://stripe.com/docs/currencies) the customer can be charged in for recurring billing purposes.
    string? currency?;
    # ID of the default payment source for the customer.
    # 
    # If you are using payment methods created via the PaymentMethods API, see the [invoice_settings.default_payment_method](https://stripe.com/docs/api/customers/object#customer_object-invoice_settings-default_payment_method) field instead.
    string|AlipayAccount|BankAccount|BitcoinReceiver|Card? default_source?;
    # When the customer's latest invoice is billed by charging automatically, `delinquent` is `true` if the invoice's latest charge failed. When the customer's latest invoice is billed by sending an invoice, `delinquent` is `true` if the invoice isn't paid by its due date.
    # 
    # If an invoice is marked uncollectible by [dunning](https://stripe.com/docs/billing/automatic-collection), `delinquent` doesn't get reset to `false`.
    boolean? delinquent?;
    # An arbitrary string attached to the object. Often useful for displaying to users.
    string? description?;
    # Describes the current discount active on the customer, if there is one.
    Discount? discount?;
    # The customer's email address.
    string? email?;
    # Unique identifier for the object.
    string? id;
    # The prefix for the customer used to generate unique invoice numbers.
    string? invoice_prefix?;
    InvoiceSettingCustomerSetting? invoice_settings?;
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    boolean? livemode;
    # Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    record {} metadata?;
    # The customer's full name or business name.
    string? name?;
    # The suffix of the customer's next invoice number, e.g., 0001.
    int? next_invoice_sequence?;
    # String representing the object's type. Objects of the same type share the same value.
    string? 'object;
    # The customer's phone number.
    string? phone?;
    # The customer's preferred locales (languages), ordered by preference.
    string[]? preferred_locales?;
    # Mailing and shipping address for the customer. Appears on invoices emailed to this customer.
    Shipping? shipping?;
    # The customer's payment sources, if any.
    Apmssourcessourcelist1? sources?;
    # The customer's current subscriptions, if any.
    Subscriptionlist1? subscriptions?;
    CustomerTax tax?;
    # Describes the customer's tax exemption status. One of `none`, `exempt`, or `reverse`. When set to `reverse`, invoice and receipt PDFs include the text **"Reverse charge"**.
    string? tax_exempt?;
    # The customer's tax IDs.
    Taxidslist1? tax_ids?;
};
public type CustomerTax record {
    # Surfaces if automatic tax computation is possible given the current customer location information.
    string automatic_tax;
    # A recent IP address of the customer used for tax reporting and tax location inference.
    string? ip_address?;
    # The customer's location as identified by Stripe Tax.
    CustomerTaxLocation location?;
};
# The customer's tax IDs.
public type Taxidslist1 record {
    # Details about each object.
    TaxId[] data;
    # True if this list has another page of items after this one that can be fetched.
    boolean has_more;
    # String representing the object's type. Objects of the same type share the same value. Always has the value `list`.
    string 'object;
    # The URL where this list can be accessed.
    string url;
};
public type TaxIdVerification record {
    # Verification status, one of `pending`, `verified`, `unverified`, or `unavailable`.
    string status;
    # Verified address.
    string? verified_address?;
    # Verified name.
    string? verified_name?;
};
# You can add one or multiple tax IDs to a [customer](https://stripe.com/docs/api/customers).
# A customer's tax IDs are displayed on invoices and credit notes issued for the customer.
# 
# Related guide: [Customer Tax Identification Numbers](https://stripe.com/docs/billing/taxes/tax-ids).
public type TaxId record {
    # Two-letter ISO code representing the country of the tax ID.
    string? country?;
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    int created;
    # ID of the customer.
    string|Customer customer?;
    # Unique identifier for the object.
    string id;
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    boolean livemode;
    # String representing the object's type. Objects of the same type share the same value.
    string 'object;
    # Type of the tax ID, one of `ae_trn`, `au_abn`, `au_arn`, `br_cnpj`, `br_cpf`, `ca_bn`, `ca_gst_hst`, `ca_pst_bc`, `ca_pst_mb`, `ca_pst_sk`, `ca_qst`, `ch_vat`, `cl_tin`, `es_cif`, `eu_vat`, `gb_vat`, `hk_br`, `id_npwp`, `il_vat`, `in_gst`, `jp_cn`, `jp_rn`, `kr_brn`, `li_uid`, `mx_rfc`, `my_frp`, `my_itn`, `my_sst`, `no_vat`, `nz_gst`, `ru_inn`, `ru_kpp`, `sa_vat`, `sg_gst`, `sg_uen`, `th_vat`, `tw_vat`, `us_ein`, or `za_vat`. Note that some legacy tax IDs have type `unknown`
    string 'type;
    # Value of the tax ID.
    string value;
    # Tax ID verification information.
    TaxIdVerification verification?;
};

public type CustomerTaxLocation record {
    # The customer's country as identified by Stripe Tax.
    string country;
    # The data source used to infer the customer's location.
    string 'source;
    # The customer's state, county, province, or region as identified by Stripe Tax.
    string? state?;
};
public type Subscriptionlist1 record {
    # Details about each object.
    //Subscription[] data;
    # True if this list has another page of items after this one that can be fetched.
    boolean has_more;
    # String representing the object's type. Objects of the same type share the same value. Always has the value `list`.
    string 'object;
    # The URL where this list can be accessed.
    string url;
};
# The customer's payment sources, if any.
public type Apmssourcessourcelist1 record {
    # Details about each object.
    AlipayAccount|BankAccount|BitcoinReceiver|Card[] data;
    # True if this list has another page of items after this one that can be fetched.
    boolean has_more;
    # String representing the object's type. Objects of the same type share the same value. Always has the value `list`.
    string 'object;
    # The URL where this list can be accessed.
    string url;
};
public type Shipping record {
    Address address?;
    # The delivery service that shipped a physical product, such as Fedex, UPS, USPS, etc.
    string? carrier?;
    # Recipient name.
    string? name?;
    # Recipient phone (including extension).
    string? phone?;
    # The tracking number for a physical product, obtained from the delivery service. If multiple tracking numbers were generated for this purchase, please separate them with commas.
    string? tracking_number?;
};

public type InvoiceSettingCustomerSetting record {
    # Default custom fields to be displayed on invoices for this customer.
    InvoiceSettingCustomField[]? custom_fields?;
    # ID of a payment method that's attached to the customer, to be used as the customer's default payment method for subscriptions and invoices.
    //string|PaymentMethod default_payment_method?;
    # Default footer to be displayed on invoices for this customer.
    string? footer?;
};
public type InvoiceSettingCustomField record {
    # The name of the custom field.
    string name;
    # The value of the custom field.
    string value;
};

# A discount represents the actual application of a coupon to a particular
# customer. It contains information about when the discount began and when it
# will end.
# 
# Related guide: [Applying Discounts to Subscriptions](https://stripe.com/docs/billing/subscriptions/discounts).
public type Discount record {
    # The Checkout session that this coupon is applied to, if it is applied to a particular session in payment mode. Will not be present for subscription mode.
    string? checkout_session?;
    # A coupon contains information about a percent-off or amount-off discount you
    # might want to apply to a customer. Coupons may be applied to [invoices](https://stripe.com/docs/api#invoices) or
    # [orders](https://stripe.com/docs/api#create_order-coupon). Coupons do not work with conventional one-off [charges](https://stripe.com/docs/api#create_charge).
    Coupon coupon;
    # The ID of the customer associated with this discount.
    string|Customer|DeletedCustomer customer?;
    # If the coupon has a duration of `repeating`, the date that this discount will end. If the coupon has a duration of `once` or `forever`, this attribute will be null.
    int? end?;
    # The ID of the discount object. Discounts cannot be fetched by ID. Use `expand[]=discounts` in API calls to expand discount IDs in an array.
    string id;
    # The invoice that the discount's coupon was applied to, if it was applied directly to a particular invoice.
    string? invoice?;
    # The invoice item `id` (or invoice line item `id` for invoice line items of type='subscription') that the discount's coupon was applied to, if it was applied directly to a particular invoice item or invoice line item.
    string? invoice_item?;
    # String representing the object's type. Objects of the same type share the same value.
    string 'object;
    # The promotion code applied to create this discount.
    string|PromotionCode promotion_code?;
    # Date that the coupon was applied.
    int 'start;
    # The subscription that this coupon is applied to, if it is applied to a particular subscription.
    string? subscription?;
};
# A Promotion Code represents a customer-redeemable code for a coupon. It can be used to
# create multiple codes for a single coupon.
public type PromotionCode record {
    # Whether the promotion code is currently active. A promotion code is only active if the coupon is also valid.
    boolean active;
    # The customer-facing code. Regardless of case, this code must be unique across all active promotion codes for each customer.
    string code;
    # A coupon contains information about a percent-off or amount-off discount you
    # might want to apply to a customer. Coupons may be applied to [invoices](https://stripe.com/docs/api#invoices) or
    # [orders](https://stripe.com/docs/api#create_order-coupon). Coupons do not work with conventional one-off [charges](https://stripe.com/docs/api#create_charge).
    Coupon coupon;
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    int created;
    # The customer that this promotion code can be used by.
    string|Customer|DeletedCustomer customer?;
    # Date at which the promotion code can no longer be redeemed.
    int? expires_at?;
    # Unique identifier for the object.
    string id;
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    boolean livemode;
    # Maximum number of times this promotion code can be redeemed.
    int? max_redemptions?;
    # Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    record {} metadata?;
    # String representing the object's type. Objects of the same type share the same value.
    string 'object;
    PromotionCodesResourceRestrictions restrictions;
    # Number of times this promotion code has been used.
    int times_redeemed;
};
public type PromotionCodesResourceRestrictions record {
    # A Boolean indicating if the Promotion Code should only be redeemed for Customers without any successful payments or invoices
    boolean first_time_transaction;
    # Minimum amount required to redeem this Promotion Code into a Coupon (e.g., a purchase must be $100 or more to work).
    int? minimum_amount?;
    # Three-letter [ISO code](https://stripe.com/docs/currencies) for minimum_amount
    string? minimum_amount_currency?;
};
public type DeletedCustomer record {
    # Always true for a deleted object
    boolean deleted;
    # Unique identifier for the object.
    string id;
    # String representing the object's type. Objects of the same type share the same value.
    string 'object;
};
# A coupon contains information about a percent-off or amount-off discount you
# might want to apply to a customer. Coupons may be applied to [invoices](https://stripe.com/docs/api#invoices) or
# [orders](https://stripe.com/docs/api#create_order-coupon). Coupons do not work with conventional one-off [charges](https://stripe.com/docs/api#create_charge).
public type Coupon record {
    # Amount (in the `currency` specified) that will be taken off the subtotal of any invoices for this customer.
    int? amount_off?;
    CouponAppliesTo applies_to?;
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    int created;
    # If `amount_off` has been set, the three-letter [ISO code for the currency](https://stripe.com/docs/currencies) of the amount to take off.
    string? currency?;
    # One of `forever`, `once`, and `repeating`. Describes how long a customer who applies this coupon will get the discount.
    string duration;
    # If `duration` is `repeating`, the number of months the coupon applies. Null if coupon `duration` is `forever` or `once`.
    int? duration_in_months?;
    # Unique identifier for the object.
    string id;
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    boolean livemode;
    # Maximum number of times this coupon can be redeemed, in total, across all customers, before it is no longer valid.
    int? max_redemptions?;
    # Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    record {} metadata?;
    # Name of the coupon displayed to customers on for instance invoices or receipts.
    string? name?;
    # String representing the object's type. Objects of the same type share the same value.
    string 'object;
    # Percent that will be taken off the subtotal of any invoices for this customer for the duration of the coupon. For example, a coupon with percent_off of 50 will make a %s100 invoice %s50 instead.
    decimal? percent_off?;
    # Date after which the coupon can no longer be redeemed.
    int? redeem_by?;
    # Number of times this coupon has been applied to a customer.
    int times_redeemed;
    # Taking account of the above properties, whether this coupon can still be applied to a customer.
    boolean valid;
};
public type CouponAppliesTo record {
    # A list of product IDs this coupon applies to
    string[] products;
};

# You can store multiple cards on a customer in order to charge the customer
# later. You can also store multiple debit cards on a recipient in order to
# transfer to those cards later.
# 
# Related guide: [Card Payments with Sources](https://stripe.com/docs/sources/cards).
public type Card record {
    # The account this card belongs to. This attribute will not be in the card object if the card belongs to a customer or recipient instead.
    string|Account account?;
    # City/District/Suburb/Town/Village.
    string? address_city?;
    # Billing address country, if provided when creating card.
    string? address_country?;
    # Address line 1 (Street address/PO Box/Company name).
    string? address_line1?;
    # If `address_line1` was provided, results of the check: `pass`, `fail`, `unavailable`, or `unchecked`.
    string? address_line1_check?;
    # Address line 2 (Apartment/Suite/Unit/Building).
    string? address_line2?;
    # State/County/Province/Region.
    string? address_state?;
    # ZIP or postal code.
    string? address_zip?;
    # If `address_zip` was provided, results of the check: `pass`, `fail`, `unavailable`, or `unchecked`.
    string? address_zip_check?;
    # A set of available payout methods for this card. Only values from this set should be passed as the `method` when creating a payout.
    string[]? available_payout_methods?;
    # Card brand. Can be `American Express`, `Diners Club`, `Discover`, `JCB`, `MasterCard`, `UnionPay`, `Visa`, or `Unknown`.
    string brand;
    # Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you've collected.
    string? country?;
    # Three-letter [ISO code for currency](https://stripe.com/docs/payouts). Only applicable on accounts (not customers or recipients). The card can be used as a transfer destination for funds in this currency.
    string? currency?;
    # The customer that this card belongs to. This attribute will not be in the card object if the card belongs to an account or recipient instead.
    string|Customer|DeletedCustomer customer?;
    # If a CVC was provided, results of the check: `pass`, `fail`, `unavailable`, or `unchecked`. A result of unchecked indicates that CVC was provided but hasn't been checked yet. Checks are typically performed when attaching a card to a Customer object, or when creating a charge. For more details, see [Check if a card is valid without a charge](https://support.stripe.com/questions/check-if-a-card-is-valid-without-a-charge).
    string? cvc_check?;
    # Whether this card is the default external account for its currency.
    boolean? default_for_currency?;
    # (For tokenized numbers only.) The last four digits of the device account number.
    string? dynamic_last4?;
    # Two-digit number representing the card's expiration month.
    int exp_month;
    # Four-digit number representing the card's expiration year.
    int exp_year;
    # Uniquely identifies this particular card number. You can use this attribute to check whether two customers who’ve signed up with you are using the same card number, for example. For payment methods that tokenize card information (Apple Pay, Google Pay), the tokenized number might be provided instead of the underlying card number.
    # 
    # *Starting May 1, 2021, card fingerprint in India for Connect will change to allow two fingerprints for the same card --- one for India and one for the rest of the world.*
    string? fingerprint?;
    # Card funding type. Can be `credit`, `debit`, `prepaid`, or `unknown`.
    string funding;
    # Unique identifier for the object.
    string id;
    # The last four digits of the card.
    string last4;
    # Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    record {} metadata?;
    # Cardholder name.
    string? name?;
    # String representing the object's type. Objects of the same type share the same value.
    string 'object;
    # The recipient that this card belongs to. This attribute will not be in the card object if the card belongs to a customer or account instead.
    string|Recipient recipient?;
    # If the card number is tokenized, this is the method that was used. Can be `android_pay` (includes Google Pay), `apple_pay`, `masterpass`, `visa_checkout`, or null.
    string? tokenization_method?;
};

public type Cardlist1 record {
    Card[] data;
    # True if this list has another page of items after this one that can be fetched.
    boolean has_more;
    # String representing the object's type. Objects of the same type share the same value. Always has the value `list`.
    string 'object;
    # The URL where this list can be accessed.
    string url;
};
# With `Recipient` objects, you can transfer money from your Stripe account to a
# third-party bank account or debit card. The API allows you to create, delete,
# and update your recipients. You can retrieve individual recipients as well as
# a list of all your recipients.
# 
# **`Recipient` objects have been deprecated in favor of
# [Connect](https://stripe.com/docs/connect), specifically Connect's much more powerful
# [Account objects](https://stripe.com/docs/api#account). Stripe accounts that don't already use
# recipients can no longer begin doing so. Please use `Account` objects
# instead.**
public type Recipient record {
    # Hash describing the current account on the recipient, if there is one.
    BankAccount active_account?;
    Cardlist1? cards?;
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    int created;
    # The default card to use for creating transfers to this recipient.
    string|Card default_card?;
    # An arbitrary string attached to the object. Often useful for displaying to users.
    string? description?;
    string? email?;
    # Unique identifier for the object.
    string id;
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    boolean livemode;
    # Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    record {} metadata;
    # The ID of the [Custom account](https://stripe.com/docs/connect/custom-accounts) this recipient was migrated to. If set, the recipient can no longer be updated, nor can transfers be made to it: use the Custom account instead.
    string|Account migrated_to?;
    # Full, legal name of the recipient.
    string? name?;
    # String representing the object's type. Objects of the same type share the same value.
    string 'object;
    string|Account rolled_back_from?;
    # Type of the recipient, one of `individual` or `corporation`.
    string 'type;
};
# This is an object representing a Stripe account. You can retrieve it to see
# properties on the account like its current e-mail address or if the account is
# enabled yet to make live charges.
# 
# Some properties, marked below, are available only to platforms that want to
# [create and manage Express or Custom accounts](https://stripe.com/docs/connect/accounts).
public type Account record {
    # Business information about the account.
    //AccountBusinessProfile business_profile?;
    # The business type.
    string? business_type?;
    //AccountCapabilities capabilities?;
    # Whether the account can create live charges.
    boolean charges_enabled?;
    //LegalEntityCompany company?;
    //AccountController controller?;
    # The account's country.
    string country?;
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    int created?;
    # Three-letter ISO currency code representing the default currency for the account. This must be a currency that [Stripe supports in the account's country](https://stripe.com/docs/payouts).
    string default_currency?;
    # Whether account details have been submitted. Standard accounts cannot receive payouts before this is true.
    boolean details_submitted?;
    # An email address associated with the account. You can treat this as metadata: it is not used for authentication or messaging account holders.
    string? email?;
    # External accounts (bank accounts and debit cards) currently attached to this account
    //Externalaccountlist1 external_accounts?;
    # Unique identifier for the object.
    string id;
    # This is an object representing a person associated with a Stripe account.
    # 
    # A platform cannot access a Standard or Express account's persons after the account starts onboarding, such as after generating an account link for the account.
    # See the [Standard onboarding](https://stripe.com/docs/connect/standard-accounts) or [Express onboarding documentation](https://stripe.com/docs/connect/express-accounts) for information about platform pre-filling and account onboarding steps.
    # 
    # Related guide: [Handling Identity Verification with the API](https://stripe.com/docs/connect/identity-verification-api#person-information).
    //Person individual?;
    # Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    record {} metadata?;
    # String representing the object's type. Objects of the same type share the same value.
    string 'object;
    # Whether Stripe can send payouts to this account.
    boolean payouts_enabled?;
    //AccountRequirements requirements?;
    # Options for customizing how the account functions within Stripe.
    //AccountSettings settings?;
    //AccountTosAcceptance tos_acceptance?;
    # The Stripe account type. Can be `standard`, `express`, or `custom`.
    string 'type?;
};
public type BitcoinReceiver record {
    # True when this bitcoin receiver has received a non-zero amount of bitcoin.
    boolean active;
    # The amount of `currency` that you are collecting as payment.
    int amount;
    # The amount of `currency` to which `bitcoin_amount_received` has been converted.
    int amount_received;
    # The amount of bitcoin that the customer should send to fill the receiver. The `bitcoin_amount` is denominated in Satoshi: there are 10^8 Satoshi in one bitcoin.
    int bitcoin_amount;
    # The amount of bitcoin that has been sent by the customer to this receiver.
    int bitcoin_amount_received;
    # This URI can be displayed to the customer as a clickable link (to activate their bitcoin client) or as a QR code (for mobile wallets).
    string bitcoin_uri;
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    int created;
    # Three-letter [ISO code for the currency](https://stripe.com/docs/currencies) to which the bitcoin will be converted.
    string currency;
    # The customer ID of the bitcoin receiver.
    string? customer?;
    # An arbitrary string attached to the object. Often useful for displaying to users.
    string? description?;
    # The customer's email address, set by the API call that creates the receiver.
    string? email?;
    # This flag is initially false and updates to true when the customer sends the `bitcoin_amount` to this receiver.
    boolean filled;
    # Unique identifier for the object.
    string id;
    # A bitcoin address that is specific to this receiver. The customer can send bitcoin to this address to fill the receiver.
    string inbound_address;
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    boolean livemode;
    # Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    record {} metadata?;
    # String representing the object's type. Objects of the same type share the same value.
    string 'object;
    # The ID of the payment created from the receiver, if any. Hidden when viewing the receiver with a publishable key.
    string? payment?;
    # The refund address of this bitcoin receiver.
    string? refund_address?;
    # A list with one entry for each time that the customer sent bitcoin to the receiver. Hidden when viewing the receiver with a publishable key.
    Bitcointransactionlist1 transactions?;
    # This receiver contains uncaptured funds that can be used for a payment or refunded.
    boolean uncaptured_funds;
    # Indicate if this source is used for payment.
    boolean? used_for_payment?;
};
# A list with one entry for each time that the customer sent bitcoin to the receiver. Hidden when viewing the receiver with a publishable key.
public type Bitcointransactionlist1 record {
    # Details about each object.
    BitcoinTransaction[] data;
    # True if this list has another page of items after this one that can be fetched.
    boolean has_more;
    # String representing the object's type. Objects of the same type share the same value. Always has the value `list`.
    string 'object;
    # The URL where this list can be accessed.
    string url;
};
public type BitcoinTransaction record {
    # The amount of `currency` that the transaction was converted to in real-time.
    int amount;
    # The amount of bitcoin contained in the transaction.
    int bitcoin_amount;
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    int created;
    # Three-letter [ISO code for the currency](https://stripe.com/docs/currencies) to which this transaction was converted.
    string currency;
    # Unique identifier for the object.
    string id;
    # String representing the object's type. Objects of the same type share the same value.
    string 'object;
    # The receiver to which this transaction was sent.
    string receiver;
};
# These bank accounts are payment methods on `Customer` objects.
# 
# On the other hand [External Accounts](https://stripe.com/docs/api#external_accounts) are transfer
# destinations on `Account` objects for [Custom accounts](https://stripe.com/docs/connect/custom-accounts).
# They can be bank accounts or debit cards as well, and are documented in the links above.
# 
# Related guide: [Bank Debits and Transfers](https://stripe.com/docs/payments/bank-debits-transfers).
public type BankAccount record {
    # The ID of the account that the bank account is associated with.
    string|Account account?;
    # The name of the person or business that owns the bank account.
    string? account_holder_name?;
    # The type of entity that holds the account. This can be either `individual` or `company`.
    string? account_holder_type?;
    # The bank account type. This can only be `checking` or `savings` in most countries. In Japan, this can only be `futsu` or `toza`.
    string? account_type?;
    # A set of available payout methods for this bank account. Only values from this set should be passed as the `method` when creating a payout.
    string[]? available_payout_methods?;
    # Name of the bank associated with the routing number (e.g., `WELLS FARGO`).
    string? bank_name?;
    # Two-letter ISO code representing the country the bank account is located in.
    string country;
    # Three-letter [ISO code for the currency](https://stripe.com/docs/payouts) paid out to the bank account.
    string currency;
    # The ID of the customer that the bank account is associated with.
    string|Customer|DeletedCustomer customer?;
    # Whether this bank account is the default external account for its currency.
    boolean? default_for_currency?;
    # Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
    string? fingerprint?;
    # Unique identifier for the object.
    string id;
    # The last four digits of the bank account number.
    string last4;
    # Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    record {} metadata?;
    # String representing the object's type. Objects of the same type share the same value.
    string 'object;
    # The routing transit number for the bank account.
    string? routing_number?;
    # For bank accounts, possible values are `new`, `validated`, `verified`, `verification_failed`, or `errored`. A bank account that hasn't had any activity or validation performed is `new`. If Stripe can determine that the bank account exists, its status will be `validated`. Note that there often isn’t enough information to know (e.g., for smaller credit unions), and the validation is not always run. If customer bank account verification has succeeded, the bank account status will be `verified`. If the verification failed for any reason, such as microdeposit failure, the status will be `verification_failed`. If a transfer sent to this bank account fails, we'll set the status to `errored` and will not continue to send transfers until the bank details are updated.
    # 
    # For external accounts, possible values are `new` and `errored`. Validations aren't run against external accounts because they're only used for payouts. This means the other statuses don't apply. If a transfer fails, the status is set to `errored` and transfers are stopped until account details are updated.
    string status;
};

public type AlipayAccount record {
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    int created;
    # The ID of the customer associated with this Alipay Account.
    string|Customer|DeletedCustomer customer?;
    # Uniquely identifies the account and will be the same across all Alipay account objects that are linked to the same Alipay account.
    string fingerprint;
    # Unique identifier for the object.
    string id;
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    boolean livemode;
    # Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    record {} metadata?;
    # String representing the object's type. Objects of the same type share the same value.
    string 'object;
    # If the Alipay account object is not reusable, the exact amount that you can create a charge for.
    int? payment_amount?;
    # If the Alipay account object is not reusable, the exact currency that you can create a charge for.
    string? payment_currency?;
    # True if you can create multiple payments using this account. If the account is reusable, then you can freely choose the amount of each payment.
    boolean reusable;
    # Whether this Alipay account object has ever been used for a payment.
    boolean used;
    # The username for the Alipay account.
    string username;
};

public type Address record {
    # City, district, suburb, town, or village.
    string? city?;
    # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
    string? country?;
    # Address line 1 (e.g., street, PO Box, or company name).
    string? line1?;
    # Address line 2 (e.g., apartment, suite, unit, or building).
    string? line2?;
    # ZIP or postal code.
    string? postal_code?;
    # State, county, province, or region.
    string? state?;
};

public type CustomerUpdateUpdatingParam record {
    string[]|string allowed_updates?;
    boolean enabled?;
};

public type CustomersCustomerBody record {
    # The customer's address.
    Address|string address?;
    # An integer amount in %s that represents the customer's current balance, which affect the customer's future invoices. A negative amount represents a credit that decreases the amount due on an invoice; a positive amount increases the amount due on an invoice.
    int balance?;
    # Either a token, like the ones returned by [Stripe.js](https://stripe.com/docs/js), or a dictionary containing a user's bank account details.
    record {}|string bank_account?;
    # A token, like the ones returned by [Stripe.js](https://stripe.com/docs/js).
    record {}|string card?;
    string coupon?;
    # ID of Alipay account to make the customer's new default for invoice payments.
    string default_alipay_account?;
    # ID of bank account to make the customer's new default for invoice payments.
    string default_bank_account?;
    # ID of card to make the customer's new default for invoice payments.
    string default_card?;
    # If you are using payment methods created via the PaymentMethods API, see the [invoice_settings.default_payment_method](https://stripe.com/docs/api/customers/update#update_customer-invoice_settings-default_payment_method) parameter.
    # 
    # Provide the ID of a payment source already attached to this customer to make it this customer's default payment source.
    # 
    # If you want to add a new payment source and make it the default, see the [source](https://stripe.com/docs/api/customers/update#update_customer-source) property.
    string default_source?;
    # An arbitrary string that you can attach to a customer object. It is displayed alongside the customer in the dashboard.
    string description?;
    # Customer's email address. It's displayed alongside the customer in your dashboard and can be useful for searching and tracking. This may be up to *512 characters*.
    string email?;
    # Specifies which fields in the response should be expanded.
    string[] expand?;
    # The prefix for the customer used to generate unique invoice numbers. Must be 3–12 uppercase letters or numbers.
    string invoice_prefix?;
    # Default invoice settings for this customer.
    CustomerParam invoice_settings?;
    # Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    record {}|string metadata?;
    # The customer's full name or business name.
    string name?;
    # The sequence to be used on the customer's next invoice. Defaults to 1.
    int next_invoice_sequence?;
    # The customer's phone number.
    string phone?;
    # Customer's preferred languages, ordered by preference.
    string[] preferred_locales?;
    # The API ID of a promotion code to apply to the customer. The customer will have a discount applied on all recurring payments. Charges you create through the API will not have the discount.
    string promotion_code?;
    # The customer's shipping information. Appears on invoices emailed to this customer.
    record {}|string shipping?;
    string 'source?;
    # Tax details about the customer.
    TaxParam tax?;
    # The customer's tax exemption. One of `none`, `exempt`, or `reverse`.
    string tax_exempt?;
    # Unix timestamp representing the end of the trial period the customer will get before being charged for the first time. This will always overwrite any trials that might apply via a subscribed plan. If set, trial_end will override the default trial period of the plan the customer is being subscribed to. The special value `now` can be provided to end the customer's trial immediately. Can be at most two years from `billing_cycle_anchor`.
    string|int trial_end?;
};

# Default invoice settings for this customer.
public type CustomerParam record {
    record {}[]|string custom_fields?;
    string default_payment_method?;
    string footer?;
};
# Tax details about the customer.
public type TaxParam record {
    string|string ip_address?;
};