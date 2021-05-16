//
//  ViewController.swift
//  SampleApp
//
//  Created by Mac OS on 9/11/20.
//  Copyright © 2020 PayFort. All rights reserved.
//

import UIKit
import PayFortSDK

class ViewController: UIViewController {

    @IBOutlet private weak var cardNumberView: CardNumberView!
    @IBOutlet private weak var holderNameView: HolderNameView!
    @IBOutlet private weak var cvcNumberView: CVCNumberView!
    @IBOutlet private weak var expiryDateView: ExpiryDateView!
    @IBOutlet private weak var saveCardSwitch: UISwitch!

    let payFortController = PayFortController.init(enviroment: .sandBox)

    @IBOutlet weak var payButton: PayButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
            
    }


}


