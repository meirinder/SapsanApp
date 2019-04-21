//
//  DoubleCreateTableViewCell.swift
//  SapsanApp
//
//  Created by Savely on 13/03/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class DoubleCreateTableViewCell: UITableViewCell {

    var viewModel: CreateOrderCellViewModel?
    var creationDictionary: ResultOrderCreation!

    func setCell() {
        let dict = viewModel?.doubleDict()
        leftLabel.setHTMLFromString(text: (dict?["leftTextLabel"] ?? "errorLabel") ?? "errorLabel")
        leftTextField.placeholder = dict?["leftTextHint"] ?? "errorHint"
//        print(dict?["leftTextKeyboard_type"])
        if dict?["leftTextKeyboardType"] == "text" {
            leftTextField.keyboardType = .default
        }
        if dict?["leftTextKeyboard_type"] == "phone" {
            leftTextField.keyboardType = .phonePad
        }
        rightLabel.setHTMLFromString(text: (dict?["rightTextLabel"] ?? "errorLabel") ?? "errorLabel")
        rightTextField.placeholder = dict?["rightTextHint"] ?? "errorHint"
        if dict?["rightTextKeyboard_type"] == "text" {
            rightTextField.keyboardType = .default
        }
        if dict?["rightTextKeyboard_type"] == "phone" {
            rightTextField.keyboardType = .phonePad
        }
        
    }
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftTextField: UITextField!
    @IBOutlet weak var rightTextField: UITextField!

    @IBAction func leftAction(_ sender: UITextField) {
        if let dict = viewModel?.doubleDict() {
            if let name = dict["leftTextName"] as? String {
                creationDictionary.dict[name] = sender.text
            }
        }
    }
    
    @IBAction func rightAction(_ sender: UITextField) {
        if let dict = viewModel?.doubleDict() {
            if let name = dict["rightTextName"] as? String {
                creationDictionary.dict[name] = sender.text
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
