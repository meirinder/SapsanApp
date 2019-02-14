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
