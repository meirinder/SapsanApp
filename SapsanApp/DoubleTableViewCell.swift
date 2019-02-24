//
//  DoubleTableViewCell.swift
//  SapsanApp
//
//  Created by Savely on 14/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class DoubleTableViewCell: FullOrderTableViewCell {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var botLabel: UILabel!
    
    override func setCell() {
        let attributes = fullOrderCellViewModel?.doubleDict()
        topLabel.attributedText = attributes?["top"]?.content?.htmlToAttributedString
        if let hexColor =  attributes?["top"]?.color {
            topLabel.textColor = UIColor(hexString:hexColor)
        }
        if let BGHexColor =  attributes?["top"]?.bgColor {
            topLabel.backgroundColor = UIColor(hexString:BGHexColor)
        }
        
        botLabel.attributedText = attributes?["bot"]?.content?.htmlToAttributedString
        if let hexColor =  attributes?["bot"]?.color {
            botLabel.textColor = UIColor(hexString:hexColor)
        }
        if let BGHexColor =  attributes?["bot"]?.bgColor {
            botLabel.backgroundColor = UIColor(hexString:BGHexColor)
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
