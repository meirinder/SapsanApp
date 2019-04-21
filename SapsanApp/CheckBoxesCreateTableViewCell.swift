//
//  CheckBoxesCreateTableViewCell.swift
//  SapsanApp
//
//  Created by Savely on 13/03/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class CheckBoxesCreateTableViewCell: UITableViewCell {

    var viewModel: CreateOrderCellViewModel?
    var creationDictionary: ResultOrderCreation!

    func setCell() {
        let dict = viewModel?.checkBoxesDict()
        leftLabel.setHTMLFromString(text: (dict?["left"] ?? "errolLabel") ?? "errorLabel")
        rightLabel.setHTMLFromString(text: (dict?["right"] ?? "errolLabel") ?? "errorLabel")

    }
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftCheckBox: UISwitch!
    @IBOutlet weak var rightCheckBox: UISwitch!
    
    @IBAction func rightAction(_ sender: UISwitch) {
        if let dict = viewModel?.checkBoxesDict() {
            if let name = dict["rightName"] as? String {
                creationDictionary.dict[name] = sender.isOn.description
            }
        }
    }
    @IBAction func leftAction(_ sender: UISwitch) {
        if let dict = viewModel?.checkBoxesDict() {
            if let name = dict["leftName"] as? String {
                creationDictionary.dict[name] = sender.isOn.description
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
