//
//  ApplePay.swift
//  SampleApp
//
//  Created by AlKalouti on 12/12/20.
//  Copyright © 2020 PayFort. All rights reserved.
//

import Foundation
import PassKit
import PayFortSDK

let payfortVC = PayFortController(enviroment: .sandBox)

extension MainViewController {
    @IBAction func applePayAction(_ sender: Any) {

        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: [.amex, .masterCard, .visa]) {
            let request = PKPaymentRequest.init()
            let payment = [PKPaymentSummaryItem(label: "Grand Total", amount: NSDecimalNumber(string: GlobalClass.returnUserDefaultsValue(key: UserDefaultsKeys.grandTotal.rawValue)))]
            request.paymentSummaryItems = payment
            request.countryCode = GlobalClass.returnUserDefaultsValue(key: UserDefaultsKeys.countryCode.rawValue)
            request.currencyCode = GlobalClass.returnUserDefaultsValue(key: UserDefaultsKeys.currencyCode.rawValue)
            if let data = returnOrderDescription() {
                request.applicationData = data
            }
            request.supportedNetworks = [.amex, .masterCard, .visa]
            request.merchantIdentifier = "merchant.test.payfort.com"
            request.merchantCapabilities = .capability3DS

            let paymentPage = PKPaymentAuthorizationViewController(paymentRequest: request)
            paymentPage?.delegate = self
            if let paymentPage = paymentPage {
                present(paymentPage, animated: true, completion: nil)
            }
        }
    }
    
    private func openAddCardForPaymentUIIfNeeded() {
        if PKPassLibrary.isPassLibraryAvailable() {
            if !PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: [.amex, .masterCard, .visa, .mada]) {
                let pass = PKPassLibrary.init()
                pass.openPaymentSetup()
            }

        }
    }
    
    private func returnOrderDescription() -> Data? {
        for item in paramsArr {
            if item.title == "order_description"  {
                if let data = item.title.data(using: .utf8) {
                    return data
                }
            }
        }
        return nil
    }
     
}

extension MainViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        
        if (payment.token.paymentData.count != 0) {
            // Call payfort
            payfortVC.callPayFortForApplePay(withRequest: extractExtraParam(),
                                                        applePayPayment: payment,
                                                        currentViewController: self) { (requestDic, responeDic) in
                print("----succsess-----")
                print("----requestDic-----\n\(requestDic)")
                print("----responeDic-----\n\(responeDic)")
                completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
                GlobalClass.openResponseViewController(from: self, response: responeDic)

            } faild: { (requestDic, responeDic, message) in
                print("----Faild-----")
                print("----requestDic-----\n\(requestDic)")
                print("----responeDic-----\n\(responeDic)")
                print("----message-----\n\(message)")
                completion(PKPaymentAuthorizationResult(status: .failure, errors: nil))
                GlobalClass.openResponseViewController(from: self, response: responeDic)

            }


//            payfortVC.callPayFortForApplePayWithRequest(extractExtraParam(), applePayPayment: payment, currentViewController: self) {  result in
//
//                switch result {
//                case .success():
//                    completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
//                case .failure(let error):
//                    print(error.errorDescription)
//                    completion(PKPaymentAuthorizationResult(status: .failure, errors: nil))
//                }
//            }

        }else {
            completion(PKPaymentAuthorizationResult(status: .failure, errors: nil))
        }
    }

    
}
