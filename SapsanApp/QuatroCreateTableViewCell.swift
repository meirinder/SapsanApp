//
//  QuatroCreateTableViewCell.swift
//  SapsanApp
//
//  Created by Savely on 13/03/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class QuatroCreateTableViewCell: UITableViewCell {

    var viewModel: CreateOrderCellViewModel?

    func setCell() {
    
        let dict = viewModel?.quatroDict()
        topLeftLabel.attributedText = dict?["topLeftTextLabel"]??.htmlToAttributedString
        topLeftTextField.placeholder = dict?["topLeftTextHint"] ?? "errorHint"
        if dict?["topLeftTextKeyboard_type"] == "text" {
            topLeftTextField.keyboardType = .default
        }
        if dict?["topLeftTextKeyboard_type"] == "phone" {
            topLeftTextField.keyboardType = .phonePad
        }
        topRightLabel.attributedText = dict?["topRightTextLabel"]??.htmlToAttributedString
        topRightTextField.placeholder = dict?["topRightTextHint"] ?? "errorHint"
        if dict?["topRightTextKeyboard_type"] == "text" {
            topRightTextField.keyboardType = .default
        }
        if dict?["topRightTextKeyboard_type"] == "phone" {
            topRightTextField.keyboardType = .phonePad
        }
        botLeftLabel.attributedText = dict?["botLeftTextLabel"]??.htmlToAttributedString
        botLeftTextField.placeholder = dict?["botLeftTextHint"] ?? "errorHint"
        if dict?["botLeftTextKeyboard_type"] == "text" {
            botLeftTextField.keyboardType = .default
        }
        if dict?["botLeftTextKeyboard_type"] == "phone" {
            botLeftTextField.keyboardType = .phonePad
        }
        botRightLabel.attributedText = dict?["botRightTextLabel"]??.htmlToAttributedString
        botRightTextField.placeholder = dict?["botRightTextHint"] ?? "errorHint"
        if dict?["botRightTextKeyboard_type"] == "text" {
            botRightTextField.keyboardType = .default
        }
        if dict?["botRightTextKeyboard_type"] == "phone" {
            botRightTextField.keyboardType = .phonePad
        }
    }
    
    @IBOutlet weak var topLeftLabel: UILabel!
    @IBOutlet weak var topRightLabel: UILabel!
    @IBOutlet weak var botLeftLabel: UILabel!
    @IBOutlet weak var botRightLabel: UILabel!
    @IBOutlet weak var topLeftTextField: UITextField!
    @IBOutlet weak var topRightTextField: UITextField!
    @IBOutlet weak var botLeftTextField: UITextField!
    @IBOutlet weak var botRightTextField: UITextField!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
