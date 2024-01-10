//
//  SdkTokenSettingViewController.swift
//  SampleApp
//
//  Created by AlKalouti on 12/9/20.
//  Copyright © 2020 PayFort. All rights reserved.
//

import UIKit

class SdkTokenSettingViewController: UIViewController {
    
    @IBOutlet weak var languageTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        languageTextField.text = GlobalClass.returnUserDefaultsValue(key: UserDefaultsKeys.sdkLanguage.rawValue)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        GlobalClass.setUserDefaults(key: UserDefaultsKeys.sdkLanguage.rawValue, value: languageTextField.text!)
        navigationController?.popViewController(animated: true)
    }
    
}
