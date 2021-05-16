//
//  MainObjectiveCViewController.m
//  SampleApp
//
//  Created by AlKalouti on 12/30/20.
//  Copyright © 2020 PayFort. All rights reserved.
//

#import "MainObjectiveCViewController.h"
#import <PayFortSDK/PayFortSDK-Swift.h>
#import <PassKit/PassKit.h>

@interface MainObjectiveCViewController ()
{
    PayFortController * payfort;
}
@end

@implementation MainObjectiveCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    payfort = [[PayFortController alloc] initWithEnviroment:PayFortEnviromentSandBox];
    payfort.isShowResponsePage = YES;
    payfort.hideLoading = YES;
    payfort.presentAsDefault = YES;
    NSLog(@"responeDic=%@",payfort.getUDID);
    // [payfort setPayFpayfortomViewNib:@""];
    [payfort callPayFortWithRequest:@{@"asd":@"asdasd"}
              currentViewController:self
                            success:^(NSDictionary *requestDic, NSDictionary *responeDic) {
//                                NSLog(@"Success");
//                                NSLog(@"requestDic=%@",requestDic);
                                NSLog(@"responeDic=%@",responeDic);
                                //assert(NO);

        
                            } canceled:^(NSDictionary *requestDic, NSDictionary *responeDic) {
//                                NSLog(@"Canceled");
//                                NSLog(@"requestDic=%@",requestDic);
//                                NSLog(@"responeDic=%@",responeDic);

                            } faild:^(NSDictionary *requestDic, NSDictionary *responeDic, NSString *message) {
//                                NSLog(@"Faild");
//                                NSLog(@"requestDic=%@",requestDic);
                                NSLog(@"''''''''''responeDic=%@",responeDic);
//                                NSLog(@"message=%@",message);
//                                 assert(NO);
                                
                            }];

}


- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                       didAuthorizePayment:(PKPayment *)payment
                                completion:(void (^)(PKPaymentAuthorizationStatus status))completion
{
    NSLog(@"Payment was authorized: %@", payment.token.paymentMethod.network);
    
    // do an async call to the server to complete the payment.
    // See PKPayment class reference for object parameters that can be passed
    BOOL asyncSuccessful = payment.token.paymentData.length != 0;
    
    if(asyncSuccessful) {

        PayFortController *payFort = [[PayFortController alloc]initWithEnviroment:PayFortEnviromentSandBox];


        [payFort callPayFortForApplePayWithRequest:@{@"asd":@"asdasd"}
                        applePayPayment:payment
                  currentViewController:self
                                success:^(NSDictionary *requestDic, NSDictionary *responeDic) {
                                    completion(PKPaymentAuthorizationStatusSuccess);
                                    NSLog(@"''''''''''responeDic=%@",responeDic);
                                    //                                NSLog(@"message=%@",message);

                                }
                                  faild:^(NSDictionary *requestDic, NSDictionary *responeDic, NSString *message) {
                                      completion(PKPaymentAuthorizationStatusFailure);
                                      NSLog(@"''''''''''responeDic=%@",responeDic);
                                      //                                NSLog(@"message=%@",message);

                                  }];

        
        
    } else {
        NSLog(@"PKPaymentAuthorizationStatusFailure");

        completion(PKPaymentAuthorizationStatusFailure);
        
        // do something to let the user know the status
        
        
        //        [Crittercism failTransaction:@"checkout"];
    }
    
}

/*
#pragma mark - Navigation

 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
