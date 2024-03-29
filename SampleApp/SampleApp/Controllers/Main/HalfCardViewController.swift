//
//  HalfCardViewController.swift
//  SampleApp
//
//  Created by Mac OS on 12/21/20.
//  Copyright © 2020 PayFort. All rights reserved.
//

import UIKit

import PayFortSDK
//import MBProgressHUD

class HalfCardViewController: UIViewController {
    
    @IBOutlet private weak var cardNumberView: CardNumberView!
    @IBOutlet private weak var holderNameView: HolderNameView!
    @IBOutlet private weak var cvcNumberView: CVCNumberView!
    @IBOutlet private weak var expiryDateView: ExpiryDateView!
    @IBOutlet private weak var saveCardSwitch: UISwitch!
    @IBOutlet weak var payButton: PayButton!
    
    @IBOutlet private weak var cardNumberErrorLabel: UILabel!
    @IBOutlet private weak var cvcNumberErrorLabel: UILabel!
    @IBOutlet private weak var expiryDateErrorLabel: UILabel!
    
    var request: [String: String]!
    var enviroment: PayFortEnviroment!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardNumberView.errorLabel = cardNumberErrorLabel
        cvcNumberView.errorLabel = cvcNumberErrorLabel
        expiryDateView.errorLabel = expiryDateErrorLabel
        
        let property = Property()
        property.textColor = .yellow
        property.backgroundColor = .green
        property.errorTextColor = .green
        property.titleTextColor = .black
        
        cardNumberView.property = property

        let builder = PayComponents(cardNumberView: cardNumberView, expiryDateView: expiryDateView, cvcNumberView: cvcNumberView, holderNameView: holderNameView, rememberMe: saveCardSwitch.isOn, language: "en")
        
        payButton.setup(with: request, enviroment: enviroment, payButtonBuilder: builder, viewController: self) {
            //MBProgressHUD.showAdded(to: self.view, animated: true)
        } success: { (requestDic, responeDic) in
            print("--success--")
            print("--requestDic--\(requestDic)")
            print("--responeDic--\(responeDic)")
            self.hide(response: responeDic)
            
        } faild: { (requestDic, responeDic, message) in
            print("--Faild--")
            print("--requestDic--\(requestDic)")
            print("--responeDic--\(responeDic)")
            print("--message--\(message)")
            self.hide(response: responeDic)
        }
        
    }
    
    @IBAction func remeberMeValueChanged(_ sender: UISwitch) {
        payButton.isRememberEnabled(sender.isOn)
    }
    
    @IBAction func dismisAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func hide(response: [String:String]) {
            //MBProgressHUD.hide(for: self.view, animated: true)
        let vc = (self.storyboard?.instantiateViewController(identifier: "ResponsePageViewController"))! as ResponsePageViewController
        vc.request = response
        vc.isFromPresent = true
        let nav = UINavigationController.init(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
}
