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

    func setCell() {
        
    }
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftCheckBox: UISwitch!
    @IBOutlet weak var rightCheckBox: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
