//
//  SelectCustomPaymentTypeVC.swift
//  SampleApp
//
//  Created by AlKalouti on 1/25/21.
//  Copyright © 2021 PayFort. All rights reserved.
//

import UIKit
import PayFortSDK

class SelectCustomPaymentTypeVC: UIViewController {

    var request: [String: String]!
    var enviroment: PayFortEnviroment!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "custom" {
            let controller = segue.destination as! CustomCardViewController
            controller.request = request
            controller.enviroment = enviroment
        }else if segue.identifier == "half" {
            let controller = segue.destination as! HalfCardViewController
            controller.request = request
            controller.enviroment = enviroment
        }
    }
}
