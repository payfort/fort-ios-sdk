//
//  ViewController.swift
//  SampleApp
//
//  Created by Mac OS on 9/11/20.
//  Copyright © 2020 PayFort. All rights reserved.
//

import UIKit
import PayFortSDK
import PassKit

class ViewController: UIViewController {


    struct Shoe {
        var name: String
        var price: Double
    }
    
    let shoeData = [
        Shoe(name: "Nike Air Force 1 High LV8", price: 110.00),
        Shoe(name: "adidas Ultra Boost Clima", price: 139.99),
        Shoe(name: "Jordan Retro 10", price: 190.00),
        Shoe(name: "adidas Originals Prophere", price: 49.99),
        Shoe(name: "New Balance 574 Classic", price: 90.00)
    ]
    
    // Storyboard outlets
    
    @IBOutlet weak var shoePickerView: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    
    var sdkToken = ""
    
    @IBAction func logDeviceIdTapped(_ sender: UIButton) {
        let payFort = PayFortController.init(enviroment: .sandBox)

        let device_id = payFort.getUDID()
        print("device Id!", "\(device_id)")
    }
    
    @IBAction func buyShoeTapped(_ sender: UIButton) {
        
        // Open Apple Pay purchase
        let selectedIndex = shoePickerView.selectedRow(inComponent: 0)
        let shoe = shoeData[selectedIndex]
        let paymentItem = PKPaymentSummaryItem.init(label: shoe.name, amount: NSDecimalNumber(value: shoe.price))
        let paymentNetworks = [PKPaymentNetwork.amex, .discover, .masterCard, .visa]
        
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks) {
            let request = PKPaymentRequest()
                request.currencyCode = "AED" // 1
                request.countryCode = "AE" // 2
                request.merchantIdentifier = "merchant.test.payfort.com" // 3
                request.merchantCapabilities = PKMerchantCapability.capability3DS // 4
                request.supportedNetworks = paymentNetworks // 5
                request.paymentSummaryItems = [paymentItem] // 6
            
            guard let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request) else
            {
                displayDefaultAlert(title: "Error", message: "Unable to present Apple Pay authorization.")
                return
            }
            paymentVC.delegate = self
            self.present(paymentVC, animated: true, completion: nil)
        }
        else {
            displayDefaultAlert(title: "Error", message: "Unable to make Apple Pay transaction.")
        }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shoePickerView.delegate = self
        shoePickerView.dataSource = self
        
    }
    
    func displayDefaultAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction private func createTokenAction(_ sender: Any) {
        
        let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
        let passphrase: String = GlobalClass.returnUserDefaultsValue(key: UserDefaultsKeys.passphrase.rawValue)
        let accessCode: String = GlobalClass.returnUserDefaultsValue(key: UserDefaultsKeys.accessCode.rawValue)
        let merchantIdentifier = GlobalClass.returnUserDefaultsValue(key: UserDefaultsKeys.merchantIdentifier.rawValue)
        
        let signatureStr: String = passphrase + "access_code=" + accessCode +
            "device_id=" + deviceID + "language=en" + "merchant_identifier=" + merchantIdentifier + "service_command=SDK_TOKEN" + passphrase
        
        let body = ["service_command": "SDK_TOKEN",
                    "merchant_identifier" : GlobalClass.returnUserDefaultsValue(key: UserDefaultsKeys.merchantIdentifier.rawValue),
                    "access_code" : GlobalClass.returnUserDefaultsValue(key: UserDefaultsKeys.accessCode.rawValue),
                    "signature" : signatureStr.sha256,
                    "language": "en",
                    "device_id" : deviceID]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        // create post request
        let url = URL(string: "https://sbcheckout.payfort.com/FortAPI/paymentApi")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            do {
                let token = try JSONDecoder().decode(Token.self, from: data)
                print(token)
                if let sdkToken = token.sdk_token {
                    DispatchQueue.main.async {
                        self?.sdkToken = sdkToken
                    }
                }
            } catch {
                print(error.localizedDescription )
            }
        }
        
        task.resume()
        
    }

    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate, PKPaymentAuthorizationViewControllerDelegate {
    
    // MARK: - Pickerview update
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return shoeData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return shoeData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let priceString = String(format: "%.02f", shoeData[row].price)
        priceLabel.text = "Price = AED \(priceString)"
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        dismiss(animated: true, completion: nil)
        
        //Perform some very basic validation on the provided contact information
        let asyncSuccessful = payment.token.paymentData.count != 0
        print("ApplePay request success")
        if asyncSuccessful || !asyncSuccessful {
            let payFort = PayFortController.init(enviroment: .sandBox)

            let request = [
                "amount" : "1000",
                "command" : "PURCHASE",
                "merchant_reference" : sdkToken,
                "currency" : "AED",
                "customer_email" : "email@domain.com",
                "language" : "en",
                "sdk_token" : sdkToken,
                "digital_wallet" : "APPLE_PAY"
            ]
                
            print("about to hit APS")
            payFort.callPayFortForApplePay(withRequest: request,
                                           applePayPayment: payment,
                                           currentViewController: self,
                                           success: { (requestDic, responeDic) in
                                            print("success")
                                            print("responeDic=\(responeDic)")
                                           },
                                           faild: { (requestDic, responeDic, message) in
                                            print("failed")
                                            print("responeDic=\(responeDic)")
                                           })
            
            displayDefaultAlert(title: "Success!", message: "The Apple Pay1 transaction was complete.")
        }
                            
    }


}


