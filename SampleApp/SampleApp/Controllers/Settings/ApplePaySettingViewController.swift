//
//  ApplePaySettingViewController.swift
//  SampleApp
//
//  Created by AlKalouti on 12/9/20.
//  Copyright © 2020 PayFort. All rights reserved.
//

import UIKit

class ApplePaySettingViewController: UIViewController {
    
    @IBOutlet weak var countryCodeTextField: UITextField!
    @IBOutlet weak var grandTotalTextField: UITextField!
    @IBOutlet weak var currencyCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryCodeTextField.text = GlobalClass.returnUserDefaultsValue(key: UserDefaultsKeys.countryCode.rawValue)
        grandTotalTextField.text = GlobalClass.returnUserDefaultsValue(key: UserDefaultsKeys.grandTotal.rawValue)
        currencyCodeTextField.text = GlobalClass.returnUserDefaultsValue(key: UserDefaultsKeys.currencyCode.rawValue)
        
    }
    
    
    @IBAction func saveAction(_ sender: Any) {
        GlobalClass.setUserDefaults(key: UserDefaultsKeys.countryCode.rawValue, value: countryCodeTextField.text!)
        GlobalClass.setUserDefaults(key: UserDefaultsKeys.grandTotal.rawValue, value: grandTotalTextField.text!)
        GlobalClass.setUserDefaults(key: UserDefaultsKeys.currencyCode.rawValue, value: currencyCodeTextField.text!)
        navigationController?.popViewController(animated: true)
        
    }
    
}
