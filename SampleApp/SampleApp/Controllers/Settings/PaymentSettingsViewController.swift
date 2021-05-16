//
//  PaymentSettingsViewController.swift
//  SampleApp
//
//  Created by AlKalouti on 12/9/20.
//  Copyright © 2020 PayFort. All rights reserved.
//

import UIKit

class PaymentSettingsViewController: UIViewController {

    @IBOutlet weak var showResponsePageSegment: UISegmentedControl!
    @IBOutlet weak var showNewThemeSegment: UISegmentedControl!
    @IBOutlet weak var hideLoadingSegment: UISegmentedControl!
    @IBOutlet weak var showFraudExtraParamSegment: UISegmentedControl!
    @IBOutlet weak var showFullPageSegment: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showResponsePageSegment.selectedSegmentIndex = GlobalClass.shared.showResponsePage ? 1 : 0
        showNewThemeSegment.selectedSegmentIndex = GlobalClass.shared.showCustomXib ? 1 : 0
        hideLoadingSegment.selectedSegmentIndex = GlobalClass.shared.hideLoading ? 1 : 0
        showFraudExtraParamSegment.selectedSegmentIndex = GlobalClass.shared.showFraudExtraParam ? 1 : 0
        showFullPageSegment.selectedSegmentIndex = GlobalClass.shared.showFullPage ? 1 : 0

    }
    
    @IBAction func saveAction(_ sender: Any) {
        GlobalClass.shared.showResponsePage = showResponsePageSegment.selectedSegmentIndex == 1 ? true : false
        GlobalClass.shared.showCustomXib = showNewThemeSegment.selectedSegmentIndex == 1 ? true : false
        GlobalClass.shared.hideLoading = hideLoadingSegment.selectedSegmentIndex == 1 ? true : false
        GlobalClass.shared.showFraudExtraParam = showFraudExtraParamSegment.selectedSegmentIndex == 1 ? true : false
        GlobalClass.shared.showFullPage = showFullPageSegment.selectedSegmentIndex == 1 ? true : false
        navigationController?.popViewController(animated: true)
    }
    
}
