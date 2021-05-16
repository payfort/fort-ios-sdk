//
//  GlobalClass.swift
//  SampleApp
//
//  Created by AlKalouti on 12/9/20.
//  Copyright © 2020 PayFort. All rights reserved.
//

import Foundation
import CommonCrypto
import UIKit

enum UserDefaultsKeys: String, CaseIterable {
    case merchantIdentifier
    case accessCode
    case sdkLanguage
    case passphrase
    case countryCode
    case grandTotal
    case currencyCode
    
}

class GlobalClass: NSObject {
    
    static let shared = GlobalClass()
    
    var showResponsePage = false
    var showCustomXib = false
    var hideLoading = false
    var showFraudExtraParam = false
    var showFullPage = true
    var command = "AUTHORIZATION"
    
    static func setUserDefaults(key : String , value : Any)  {
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    
    static func deleteUserDefaults(key : String )  {
        let defaults:UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
    }
    
    static func returnUserDefaultsValue(key : String) -> String {
        let defaults:UserDefaults = UserDefaults.standard
        
        if let value:String = defaults.string(forKey: key)
        {
            return value
        }
        return ""
    }
    
    static func setDefualtValueToUserDefaults() {
        if GlobalClass.returnUserDefaultsValue(key: UserDefaultsKeys.countryCode.rawValue).isEmpty {
            GlobalClass.setUserDefaults(key: UserDefaultsKeys.countryCode.rawValue, value: "US")
            GlobalClass.setUserDefaults(key: UserDefaultsKeys.grandTotal.rawValue, value: "1.99")
            GlobalClass.setUserDefaults(key: UserDefaultsKeys.currencyCode.rawValue, value: "USD")
        }
    }


    static func returnParamsArray() -> [ExtraParam] {
        var arr : [ExtraParam] = []
        
        arr.append(ExtraParam(title: "customer_type", text: ""))
        arr.append(ExtraParam(title: "customer_first_name", text: ""))
        arr.append(ExtraParam(title: "customer_middle_initial", text: ""))
        arr.append(ExtraParam(title: "customer_address1", text: ""))
        arr.append(ExtraParam(title: "customer_phone", text: ""))
        arr.append(ExtraParam(title: "ship_type", text: ""))
        arr.append(ExtraParam(title: "ship_first_name", text: ""))
        arr.append(ExtraParam(title: "ship_last_name", text: ""))
        arr.append(ExtraParam(title: "ship_method", text: ""))
        arr.append(ExtraParam(title: "device_fingerprint", text: ""))
        arr.append(ExtraParam(title: "cart_details", text: ""))
        arr.append(ExtraParam(title: "command", text: GlobalClass.shared.command))
        arr.append(ExtraParam(title: "currency", text: ""))
        arr.append(ExtraParam(title: "amount", text: ""))
        arr.append(ExtraParam(title: "sdk_token", text: ""))
        arr.append(ExtraParam(title: "customer_email", text: ""))
        arr.append(ExtraParam(title: "merchant_reference", text: ""))
        arr.append(ExtraParam(title: "check_fraud", text: ""))
        arr.append(ExtraParam(title: "customer_ip", text: ""))
        arr.append(ExtraParam(title: "order_description", text: ""))
        arr.append(ExtraParam(title: "customer_name", text: ""))
        arr.append(ExtraParam(title: "language", text: ""))
        arr.append(ExtraParam(title: "token_name", text: ""))
        arr.append(ExtraParam(title: "payment_option", text: ""))
        arr.append(ExtraParam(title: "eci", text: ""))
        arr.append(ExtraParam(title: "return_url", text: ""))
        arr.append(ExtraParam(title: "card_number", text: ""))
        arr.append(ExtraParam(title: "expiry_date", text: ""))
        arr.append(ExtraParam(title: "remember_me", text: ""))
        arr.append(ExtraParam(title: "check_3ds", text: ""))
        arr.append(ExtraParam(title: "card_security_code", text: ""))
        arr.append(ExtraParam(title: "merchant_token", text: ""))
        arr.append(ExtraParam(title: "digital_wallet", text: ""))
        arr.append(ExtraParam(title: "phone_number", text: ""))
        arr.append(ExtraParam(title: "settlement_reference", text: ""))
        arr.append(ExtraParam(title: "dynamic_descriptor", text: ""))
        arr.append(ExtraParam(title: "merchant_extra", text: ""))
        arr.append(ExtraParam(title: "merchant_extra1", text: ""))
        arr.append(ExtraParam(title: "merchant_extra2", text: ""))
        arr.append(ExtraParam(title: "merchant_extra3", text: ""))
        arr.append(ExtraParam(title: "merchant_extra4", text: ""))
        arr.append(ExtraParam(title: "flex_value", text: ""))
        
        if GlobalClass.shared.showFraudExtraParam {
            arr.append(ExtraParam(title: "ship_address_state", text: ""))
            arr.append(ExtraParam(title: "customer_id", text: ""))
            arr.append(ExtraParam(title: "ship_zip_code", text: ""))
            arr.append(ExtraParam(title: "ship_country_code", text: ""))
            arr.append(ExtraParam(title: "customer_last_name", text: ""))
            arr.append(ExtraParam(title: "ship_phone", text: ""))
            arr.append(ExtraParam(title: "customer_address2", text: ""))
            arr.append(ExtraParam(title: "customer_apartment_no", text: ""))
            arr.append(ExtraParam(title: "customer_city", text: ""))
            arr.append(ExtraParam(title: "customer_state", text: ""))
            arr.append(ExtraParam(title: "customer_zip_code", text: ""))
            arr.append(ExtraParam(title: "customer_alt_phone", text: ""))
            arr.append(ExtraParam(title: "customer_date_birth", text: ""))
            arr.append(ExtraParam(title: "ship_middle_name", text: ""))
            arr.append(ExtraParam(title: "ship_alt_phone", text: ""))
            arr.append(ExtraParam(title: "ship_address1", text: ""))
            arr.append(ExtraParam(title: "ship_address2", text: ""))
            arr.append(ExtraParam(title: "ship_apartment_no", text: ""))
            arr.append(ExtraParam(title: "ship_address_city", text: ""))
            arr.append(ExtraParam(title: "ship_email", text: ""))
            arr.append(ExtraParam(title: "ship_comments", text: ""))
            arr.append(ExtraParam(title: "fraud_extra1", text: ""))
            arr.append(ExtraParam(title: "fraud_extra2", text: ""))
            arr.append(ExtraParam(title: "fraud_extra3", text: ""))
            arr.append(ExtraParam(title: "fraud_extra4", text: ""))
            arr.append(ExtraParam(title: "fraud_extra5", text: ""))
            arr.append(ExtraParam(title: "fraud_extra6", text: ""))
            arr.append(ExtraParam(title: "fraud_extra7", text: ""))
            arr.append(ExtraParam(title: "fraud_extra8", text: ""))
            arr.append(ExtraParam(title: "fraud_extra9", text: ""))
            arr.append(ExtraParam(title: "fraud_extra10", text: ""))
            arr.append(ExtraParam(title: "fraud_extra11", text: ""))
            arr.append(ExtraParam(title: "fraud_extra12", text: ""))
            arr.append(ExtraParam(title: "fraud_extra13", text: ""))
            arr.append(ExtraParam(title: "fraud_extra14", text: ""))
            arr.append(ExtraParam(title: "fraud_extra15", text: ""))
            arr.append(ExtraParam(title: "fraud_extra16", text: ""))
            arr.append(ExtraParam(title: "fraud_extra17", text: ""))
            arr.append(ExtraParam(title: "fraud_extra18", text: ""))
            arr.append(ExtraParam(title: "fraud_extra19", text: ""))
            arr.append(ExtraParam(title: "fraud_extra20", text: ""))
            arr.append(ExtraParam(title: "fraud_extra21", text: ""))
            arr.append(ExtraParam(title: "fraud_extra22", text: ""))
            arr.append(ExtraParam(title: "fraud_extra23", text: ""))
            arr.append(ExtraParam(title: "fraud_extra24", text: ""))
            arr.append(ExtraParam(title: "fraud_extra25", text: ""))
            
        }
        
        arr = arr.sorted(by: { $0.title < $1.title })
        
        return arr
    }
    
    static func openResponseViewController(from controller: UIViewController, response: [String:String]) {
        let vc = (controller.storyboard?.instantiateViewController(identifier: "ResponsePageViewController"))! as ResponsePageViewController
        vc.request = response
        controller.navigationController?.pushViewController(vc, animated: true)
    }
}


public extension String {
    
    var sha256: String {
        let data = Data(utf8)
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        
        data.withUnsafeBytes { buffer in
            _ = CC_SHA256(buffer.baseAddress, CC_LONG(buffer.count), &hash)
        }
        
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
}
