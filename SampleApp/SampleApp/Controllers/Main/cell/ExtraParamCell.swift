//
//  ExtraParamCell.swift
//  SampleApp
//
//  Created by AlKalouti on 12/11/20.
//  Copyright © 2020 PayFort. All rights reserved.
//

import UIKit

class ExtraParamCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak private var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(extraParam: ExtraParam) {
        titleLabel.text = extraParam.title
        textField.placeholder = extraParam.title
        textField.text = extraParam.text
    }
    
}
