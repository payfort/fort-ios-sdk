# FORT iOS SDK

# Intro

The FORT Mobile SDK allows Merchants to securely integrate the payment functions. It also allows Merchants to easily accept In-App payments. Instead of the traditional, time-consuming, and complex way of being redirected to the mobile browser to complete the payment, In-App payments can be completed through our FORT Mobile SDK. In turn, this gives the Merchant’s consumers a smooth, pleasing user-experience by using In-App payment functions through the native applications.

# Getting Started

In order to start using FORT iOS SDK you need to have an account on the FORT , please click here to follow the installation instructions using the link [below](https://github.com/payfort/fort-ios-sdk/wiki)


## Before you start the integration

Read through the following steps first to understand how the integration
process works. This will help you to understand why these steps are
required and why you need to follow a specific sequence.

**Step 1: Access your test account**

You need to make sure that you have access to a test account with Amazon
Payment Services. It is a full test environment that allows you to fully
simulate transactions.

**Step 2: Choose between a standardized or custom payment UI**

The Amazon Payment Services iOS SDK provides you with a standard payment
UI that you can use to quickly integrate in-app payments. [The standard
UI offers limited
customizability](#customizing-the-standard-payment-ui).

Alternatively, you can choose to build your own payment UI using Amazon
Payment Services iOS SDK building blocks, [we describe this in the
section on custom-coding a payment processing
UI](#using-a-custom-payment-processing-ui).

**Step 3: Make sure that you are using the correct integration type**

Prior to building the integration, you need to make sure that you are
selecting and using the proper parameters in the API calls as per the
required integration type. All the mandatory parameters are mentioned
under every section in the API document

**Step 4: Install the Amazon Payment Services iOS SDK in your development 
environment**

You need to download our iOS SDK from the link provided. Next you need
to include the iOS SDK in your Xcode project by following the steps in
the next section. You are also required to install the library and to
integrate the iOS SDK into your app.

**Step 5: Create a test transaction request**

You need to create a test transaction request. Processing a valid API
request depends on the transaction parameters included, you need to
check the documentation and review every parameter to reduce the errors
in processing the transaction.

**Step 6: Process a transaction response**

After every payment, Amazon Payment Services returns the transaction
response on the URL configured in your account under **Technical
Settings**, **Channel Configuration**.

For more details [review the transaction feedback
instructions](#amazon-payment-services-ios-sdk-transaction-feedback) in
this section. You need to validate the response parameters returned on
this URL by calculating the signature for the response parameters using
the SHA response phrase configured in your account under security
settings.

**Step 7: Test and Go Live**

You can use our test card numbers to test your integration and simulate
your test cases. The Amazon Payment Services team may need to test your
integration before going live to assure your application integration.


# Installing the Mobile SDK
1.  Obtain the Amazon Payment Services iOS Mobile SDK by downloading it
    [from the Amazon Payment Services
    website](https://github.com/payfort/fort-ios-sdk).
    

2.  Extract the folder you downloaded in the previous step.

3.  Drag **PayFortSDK.xcframework** into the **Frameworks**,
    **Libraries**, and **Embedded Content** section of your target.

# Creating a mobile SDK token
 A mobile SDK authentication token is required to authenticate every
request sent to the SDK. The token is also significant to process
payment operations with Amazon Payment Services through our iOS mobile
SDK.

To get started with our iOS mobile SDK you must first establish the
ability to generate a mobile SDK token.

**[NOTE]: The creation and initiation of a mobile SDK token happens
on your server -- your server must generate the token by sending a
request to the Amazon Payment Services API.**

**[NOTE:] A unique authentication token must be created for each
transaction. Each authentication token has a life-time of only one hour
if no new request from the same device is sent.**

### Mobile SDK token URLs

These are the URLs you need to use when you request a mobile SDK token
for your iOS app:

**Test Environment URL**

https://sbpaymentservices.payfort.com/FortAPI/paymentApi

**Production Environment URL**

https://paymentservices.payfort.com/FortAPI/paymentApi

```
curl -H "Content-Type: application/json" -d
'{"command":"SDK_TOKEN","language":"en","access_code":"xxxxx","merchant_identifier":"xxxx",,"language":"en","device_id":"ffffffff-a9fa-0b44-7b27-29e70033c587",
"signature":"7cad05f0212ed933c9a5d5dffa31661acf2c827a"}'
https://sbpaymentservices.payfort.com/FortAPI/paymentApi

```

# Processing transactions with the iOS SDK
As a merchant you have two ways in which you can process payments using
the Amazon Payment Services iOS mobile SDK.

1.  **Standard payment screen.** You can use the standard Amazon Payment
    Services iOS SDK interface to display a standard payment screen.

    This standard payment view is customizable in three ways. You can
    hide the loading screen, and you can change the presentation style
    from full screen to OS default. You can also customize some of the
    UI elements. We address customizing the standard payment screen [in this
    section](#amazon-payment-services-ios-sdk-transaction-feedback).

2.  **Custom integration**. You can choose to build your own payment
    processing screen by coding your own payment processing screen. With
    this mobile SDK feature, we allow merchants to integrate a native
    app checkout experience without displaying our standard payment
    screen -- while still using SDK features for rapid go-live.
    

# Steps for standard checkout

These are the steps you need to follow to perform a checkout using our
standard UI. See the next section for building your own customized
payment UI.

1- **Import the framework into your app**
    
    Start by importing the Amazon Payment Service iOS SDK library. You
    do so by using the following code:
    
**Objective-C**

 ``` 
  
  #import < PayFortSDK/PayFortSDK-Swift.h>
  
```

**Swift**

 ``` 
  
  import PayFortSDK
  
```

2- **Initialize the controllers**

    Initialize **PayFortController** within the targeted environment.
    You set the target environment by setting one of the two ENUM,
    either **PayFortEnviromentSandBox** or
    **PayFortEnviromentProduction**
    
**Objective-C**

 ``` 
  
  PayFortController *payFort = [[PayFortController alloc]initWithEnviroment: PayFortEnviromentSandBox];
  
```

**Swift**

  ```

  
  let payFort = PayFortController.init(enviroment: .sandBox)
  
```

3-   **Preparing Request Parameters**
    
    Set a dictionary that contains all keys and values for the SDK

 **Objective-C**

```


NSMutableDictionary *request = [[NSMutableDictionary alloc]init];
[request setValue:@"10000" forKey:@"amount"];
[request setValue:@"AUTHORIZATION" forKey:@"command"];
[request setValue:@"USD" forKey:@"currency"];
[request setValue:@ "email@domain.com" forKey:@"customer_email"]
[request setValue:@"en" forKey:@"language"]; 
[request setValue:@"112233682686" forKey:@"merchant_reference"]
[request setValue:@"SDK TOKEN GOES HERE" forKey:@"sdk_token"];
[request setValue:@"" forKey:@"payment_option"];
[request setValue:@"gr66zzwW9" forKey:@"token_name"]; 


```

**Swift**

```


let request = ["amount" : "1000",
    "command" : "AUTHORIZATION",
    "currency" : "AED",
    "customer_email" : "rzghebrah@payfort.com",
    "installments" : "",
    "language" : "en",
    "sdk_token" : "token"]


```

</br>

4 . **Response callback function**

Amazon Payment Services allows you retrieve and receive the response
parameters after processing a transaction once the transaction is
completed. It only happens during the installation process. This is
the code you need to use:
**Objective-C**

```


[payFort callPayFortWithRequest:request currentViewController:self
                            success:^(NSDictionary *requestDic, NSDictionary *responeDic) { NSLog(@"Success");
        NSLog(@"responeDic=%@",responeDic);
    }
                           canceled:^(NSDictionary *requestDic, NSDictionary *responeDic) { NSLog(@"Canceled");
        NSLog(@"responeDic=%@",responeDic);
    }
                              faild:^(NSDictionary *requestDic, NSDictionary *responeDic, NSString *message) {
        NSLog(@"Faild");
        NSLog(@"responeDic=%@",responeDic);
    }];


```

**Swift**

```


payFort.callPayFort(withRequest: request, currentViewController: self, success: { (requestDic, responeDic) in    print("success")
        },
        canceled: { (requestDic, responeDic) in
            print("canceled")
        },    faild: { (requestDic, responeDic, message) in print("faild")
})


```
## Complete sample code for standard UI checkout
## Complete sample code for standard UI checkout:

The following sample code shows you how to process a payment using the
standard view. The code sample illustrates how you send a request
operation in the mobile SDK.

**Objective-C**

```


- (void)viewDidLoad {
    [super viewDidLoad];
    payfort = [[PayFortController alloc] initWithEnviroment:PayFortEnviromentSandBox];
}    

NSMutableDictionary *requestDictionary = [[NSMutableDictionary alloc]init]; 
[requestDictionary setValue:@"10000" forKey:@"amount"];
[requestDictionary setValue:@"AUTHORIZATION" forKey:@"command"]; 
[requestDictionary setValue:@"USD" forKey:@"currency"];
[requestDictionary setValue:@"email@domain.com" forKey:@"customer_email"];
[requestDictionary setValue:@"en" forKey:@"language"];
[requestDictionary setValue:@"112233682686" forKey:@"merchant_reference"];
[requestDictionary setValue:@"" forKey:@"payment_option"];
[requestDictionary setValue:@"gr66zzwW9" forKey:@"token_name"];
    
    [payFort callPayFortWithRequest:requestDictionary currentViewController:self success:^(NSDictionary *requestDic, NSDictionary *responeDic) {
        
    } canceled:^(NSDictionary *requestDic, NSDictionary *responeDic) {
    } faild:^(NSDictionary *requestDic, NSDictionary *responeDic, NSString *message) {
        
    }];


```

**Swift**

```


let request = ["amount" : "1000",
                           "command" : "AUTHORIZATION",
                           "currency" : "AED",
                           "customer_email" : "rzghebrah@payfort.com",
                           "installments" : "",
                           "language" : "en",
                           "sdk_token" : "token"]

payFort.callPayFort(withRequest: request, currentViewController: self,
                                      success: { (requestDic, responeDic) in
                                        print("success")
                                        print("responeDic=\(responeDic)")
                                        print("responeDic=\(responeDic)")
                                        
                                      },
                                      canceled: { (requestDic, responeDic) in
                                        print("canceled")
                                        print("responeDic=\(responeDic)")
                                        print("responeDic=\(responeDic)")
 
                                      },
                                      faild: { (requestDic, responeDic, message) in
                                        print("faild")
                                        print("responeDic=\(responeDic)")
                                        print("responeDic=\(responeDic)")
					})


```
### Customizing the standard payment UI
When you use the standard payment UI you can customize the payment UI
presented by our iOS SDK in a number of ways to better reflect your
business. We outline your options below.

### Customizing the standard payment UI

You can customize the standard payment user interface in your iOS app.
This is an example of a customized payment UI:

![iOS payment layout](images/ios-mobile-SDK-Payment-Layout.png)

Standard vs. Customized Mobile SDK Payment Page

Follow these steps to configure a customized payment UI:

1.  Create your nibFile .xib and set the name of Arabic xib same name
    with English one with suffix -ar.

2.  Link the xib with PayFortView and bind all the IBOutlets in
    interface section IBOutlet UILabel \*titleLbl;

```

IBOutlet UIButton *BackBtn;
IBOutlet UILabel *PriceLbl;
IBOutlet JVFloatLabeledTextField *CardNameTxt; 
IBOutlet JVFloatLabeledTextField *CardNumberTxt; 
IBOutlet JVFloatLabeledTextField *CVCNumberTxt; 
IBOutlet JVFloatLabeledTextField *ExpDateTxt; 
IBOutlet UILabel *cardNumberErrorlbl;
IBOutlet UILabel *cVCNumberErrorlbl;
IBOutlet UILabel *expDateErrorlbl;
IBOutlet UISwitch *savedCardSwitch;
IBOutlet UIButton *paymentBtn;
IBOutlet UILabel *saveCardLbl;
IBOutlet UIImageView *imageCard;


```

3.  Assign new created xib file to Amazon Payment Services controller.

```


[payFort setPayFortCustomViewNib:@\"PayFortView2\"\];

```


**[NOTE]. If you call Arabic view and the Arabic view not existed
the application will crash.\
Don't forget to set the custom view field in the identity inspector**

### Hiding the Amazon Payment Service loading prompt

There is an option to hide the loading prompt when the iOS SDK
initializes the connection request. You can disable the loading prompt
by using following option:


**Objective-C**

```

  
payFort.hideLoading = YES;

```

**Swift**
```

  
 payFort.hideLoading = true

```

  

### Changing the presentation style

It's easy to change the presentation style from full screen to default
by using the following property:

**Objective-C**
```

  
payFort.presentAsDefault  = YES;

 ``` 

**Swift**
```  

  
 payFort.presentAsDefault  = true

```  
# Using a custom payment processing UI
In this section we outline the key information you need to create your
own payment processing screen using the tools in the iOS SDK.

### Stage 1: Generate an SDK token

You need to generate an SDK token before you can start processing
payments using your custom payment processing UI. Refer to the SDK token
section earlier in this document for instructions on creating an SDK
token.

### Stage 2: Create the card components

You create your custom payment screen by using the following five
components included in the Amazon Payment Services iOS SDK:

-   CardNumberView

-   CVCNumberView

-   ExpiryDateView

-   CardHolderNameView

-   PayButton

**Components Views**

Item property, all these properties are available for each component.

**Swift**

```


let property = Property()
        property.textColor
        property.fontStyle
        property.backgroundColor
        property.errorFontStyle
        property.errorTextColor
        property.titleTextColor
        property.titleErrorTextColor
        property.titleFontStyle


```

**Objective-c**

```


Property *property = [[Property alloc] init]
        property.textColor
        property.fontStyle
        property.backgroundColor
        property.errorFontStyle
        property.errorTextColor
        property.titleTextColor
        property.titleErrorTextColor
        property.titleFontStyle


```

1.  **CardNumberView:**

The **CardNumberView** inheritance from UIView, **CardNumberView is**
used to validate the card number, card brand and card number length.

**Swift**
```


@IBOutlet private weak var cardNumberView: CardNumberView!
cardNumberView.property = property


```
**Objective-c**
```


@property (nonatomic, weak) IBOutlet CardNumberView *cardNumberView;
cardNumberView.property = property


```
2.  **ExpiryDateView**:

The **ExpiryDateView** inheritance from UIView, **ExpiryDateView** is
used to check the expiry date for the credit card.

**Swift**
```


@IBOutlet private weak var expiryDateView: ExpiryDateView!
     expiryDateView.property = property


```
**Objective-c**
```


@property (nonatomic, weak) IBOutlet ExpiryDateView *expiryDateView;
     expiryDateView.property = property


```
3.  **CVCNumberView**

The **CVCNumberView** inheritance from UIView, **CVCNumberView** used
to check if cvc matches cardBrad.

**Swift**
```


@IBOutlet private weak var cvcNumberView: CVCNumberView!
   cvcNumberView.property = property


```
**Objective-c**
```


@property (nonatomic, weak) IBOutlet CVCNumberView *cvcNumberView;
     cvcNumberView.property = property


```
4.  **HolderNameView**

The **HolderNameView** inheritance from UIView, **HolderNameView** is
used to fill the card holder name.

**Swift**
```


@IBOutlet private weak var holderNameView: HolderNameView!
     holderNameView.property = property


```
**Objective-c**
```


@property (nonatomic, weak) IBOutlet holderNameView *holderNameView;
     holderNameView.property = property


```
5.  **ErrorLabel**

 It will show any error message for owner card view, you can set your
 custom UILabel, Example:

 **Swift**
```


@IBOutlet private weak var cardNumberErrorLabel: ErrorLabel!
   cardNumberView.errorLabel = cardNumberErrorLabel


```
 **Objective-c**
```


@property (nonatomic, weak) IBOutlet ErrorLabel *cardNumberErrorLabel;
   cardNumberView.errorLabel = cardNumberErrorLabel


```
</br>

**Example of components views in Objective-C and Swift**

This is one example of how to customize the component:

**Swift**
```


let property = Property()
    property.textColor = .yellow
    property.backgroundColor = .green
    property.errorTextColor = .green
    property.titleTextColor = .red    
    cardNumberView.property = property


```
**Objective-c**
```


Property * property = [[Property alloc] init];
    property.textColor = UIColor.yellowColor;
    property.backgroundColor = UIColor.greenColor;
    property.errorTextColor = UIColor.greenColor;
    property.titleTextColor = UIColor.redColor;    
    cardNumberView.property = property;


```
###  Stage 3: Initiate the payment


**PayButton**

Used to collect the card data from card components above and to submit
successful payment. With a few simple steps it also has the capability
to perform Direct Pay without the need for the card component, see the
next section.

**PayfortPayButton methods**
```


/**
     Update Request After doing Setup
     - Parameter request: a new request dictionary
     */
    public func updateRequest(request: [String: String])
    
 /**
     Responsible for Save token or not
     - Parameter enabled: a new bool value
     */
    public func isRememberEnabled(_ enabled: Bool)


```
### Sample code

In this section we illustrate how you use the PayButton using sample
code for Swift and Objective-C.

**Swift**
```


@IBOutlet weak var payButton: PayButton!
    
    let builder = PayComponents(cardNumberView: cardNumberView, expiryDateView: expiryDateView, cvcNumberView: cvcNumberView, holderNameView: holderNameView, rememberMe: saveCardSwitch.isOn)

    payButton.setup(with: request, enviroment: enviroment, payComponents: builder, viewController: self) {
    // Process started
    } success: { (requestDic, responeDic) in
    // Process success
    } faild: { (requestDic, responeDic, message) in
    // Process faild
    }


```
**Objective-C**
```


@property (nonatomic, weak) IBOutlet PayButton *payButton;
    
    PayComponents *builder = [[PayComponents alloc] initWithCardNumberView:cardNumberView expiryDateView: expiryDateView cvcNumberView: cvcNumberView, holderNameView: holderNameView rememberMe: saveCardSwitch.on];
    
    [payButton setupWithRequest: request
                     enviroment: enviroment
                  payComponents: builder
          currentViewController: self
                        Success:^(NSDictionary *requestDic, NSDictionary *responeDic) {
    } Canceled:^(NSDictionary *requestDic, NSDictionary *responeDic) {
    } Faild:^(NSDictionary *requestDic, NSDictionary *responeDic, NSString *message) {
    }];


```
## Stage 3: Initiate the payment
### Sample code
