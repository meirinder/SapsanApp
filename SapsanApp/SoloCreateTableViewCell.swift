//
//  SoloTableViewCell.swift
//  SapsanApp
//
//  Created by Savely on 13/03/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class SoloCreateTableViewCell: UITableViewCell {

    var viewModel: CreateOrderCellViewModel?
    var creationDictionary: ResultOrderCreation!

    
    func setCell() {
        let dict = viewModel?.soloDict()
        questionLabel.setHTMLFromString(text: (dict?["label"] ?? "errolLabel") ?? "errorLabel")
        answerTextField.placeholder = dict?["hint"] ?? "errorHint"
        if dict?["keyboard_type"] == "text" {
            answerTextField.keyboardType = .default
        }
        if dict?["keyboard_type"] == "phone" {
            answerTextField.keyboardType = .phonePad
        }
        
    }
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBAction func endAction(_ sender: UITextField) {
        if let dict = viewModel?.soloDict() {
            if let name = dict["name"] as? String {
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
