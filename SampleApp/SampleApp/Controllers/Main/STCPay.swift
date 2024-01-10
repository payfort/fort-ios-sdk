//
//  STCPay.swift
//  SampleApp
//
//  Created by Cetinkaya, Ozgen on 3/14/23.
//  Copyright © 2023 PayFort. All rights reserved.
//

import Foundation
import PayFortSDK

let vc = STCPayViewController.init(enviroment: .sandBox)

extension MainViewController {
    @IBAction func STCPayAction(_ sender: Any) {
        
        let params = extractExtraParam()
        
        vc.openPaymentPage(with: params,
                                      currentViewController: self) { requestDic, responeDic in
            print(requestDic)
            print(responeDic)
            GlobalClass.openResponseViewController(from: self, response: responeDic)
        } faild: { requestDic, responeDic, message in
            print("request failed")
            print(requestDic)
            print(responeDic)
            GlobalClass.openResponseViewController(from: self, response: responeDic)
        } canceled: { requestDic, responeDic in
            print("request cancelled")
        }
    }
}
