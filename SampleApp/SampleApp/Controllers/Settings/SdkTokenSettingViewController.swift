//
//  SdkTokenSettingViewController.swift
//  SampleApp
//
//  Created by AlKalouti on 12/9/20.
//  Copyright © 2020 PayFort. All rights reserved.
//

import UIKit

class SdkTokenSettingViewController: UIViewController {
    
    @IBOutlet weak var merchantIdentifierTextField: UITextField!
    @IBOutlet weak var accessCodeTextField: UITextField!
    @IBOutlet weak var languageTextField: UITextField!
    @IBOutlet weak var passphraseText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        merchantIdentifierTextField.text = GlobalClass.returnUserDefaultsValue(key: UserDefaultsKeys.merchantIdentifier.rawValue)
        accessCodeTextField.text = GlobalClass.returnUserDefaultsValue(key: UserDefaultsKeys.accessCode.rawValue)
        languageTextField.text = GlobalClass.returnUserDefaultsValue(key: UserDefaultsKeys.sdkLanguage.rawValue)
        passphraseText.text = GlobalClass.returnUserDefaultsValue(key: UserDefaultsKeys.passphrase.rawValue)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        GlobalClass.setUserDefaults(key: UserDefaultsKeys.merchantIdentifier.rawValue, value: merchantIdentifierTextField.text!)
        GlobalClass.setUserDefaults(key: UserDefaultsKeys.accessCode.rawValue, value: accessCodeTextField.text!)
        GlobalClass.setUserDefaults(key: UserDefaultsKeys.sdkLanguage.rawValue, value: languageTextField.text!)
        GlobalClass.setUserDefaults(key: UserDefaultsKeys.passphrase.rawValue, value: passphraseText.text!)
        navigationController?.popViewController(animated: true)
    }
    
}
