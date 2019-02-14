//
//  MultiTableViewCell.swift
//  SapsanApp
//
//  Created by Savely on 14/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class MultiTableViewCell: FullOrderTableViewCell {

    @IBOutlet weak var leftKeyLabel: UILabel!
    @IBOutlet weak var leftValueButton: UIButton!
    @IBOutlet weak var rightKeyLabel: UILabel!
    @IBOutlet weak var rightValueButton: UIButton!
    
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
