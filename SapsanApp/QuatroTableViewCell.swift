//
//  QuatroTableViewCell.swift
//  SapsanApp
//
//  Created by Savely on 14/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class QuatroTableViewCell: FullOrderTableViewCell {
    @IBOutlet weak var topLeftLabel: UILabel!
    @IBOutlet weak var botLeftLabel: UILabel!
    @IBOutlet weak var topRightLabel: UILabel!
    @IBOutlet weak var botRightLabel: UILabel!
    
    override func setCell() {
        let attributes = fullOrderCellViewModel?.quatroDict()
        topLeftLabel.text = attributes?["topLeft"]?.content
        botLeftLabel.text = attributes?["botLeft"]?.content
        topRightLabel.text = attributes?["topRight"]?.content
        botRightLabel.text = attributes?["botRight"]?.content
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
