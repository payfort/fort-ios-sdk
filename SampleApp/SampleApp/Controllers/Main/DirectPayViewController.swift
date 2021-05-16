//
//  DirectPayViewController.swift
//  SampleApp
//
//  Created by AlKalouti on 1/17/21.
//  Copyright © 2021 PayFort. All rights reserved.
//

import UIKit
import PayFortSDK
import MBProgressHUD

class DirectPayViewController: UIViewController {

    @IBOutlet weak var directPayButton: PayButton!
    var request: [String: String]!
    var enviroment: PayFortEnviroment! {
        didSet {
            payFortController = PayFortController.init(enviroment: enviroment)
        }
    }

    var payFortController: PayFortController!

    override func viewDidLoad() {
        super.viewDidLoad()

        directPayButton.setup(with: request, enviroment: enviroment, viewController: self) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
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
    
    
    func hide(response: [String:String]) {
            MBProgressHUD.hide(for: self.view, animated: true)
            GlobalClass.openResponseViewController(from: self, response: response)
    }

    
}
