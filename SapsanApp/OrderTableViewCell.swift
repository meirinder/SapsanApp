//
//  OrderTableViewCell.swift
//  SapsanApp
//
//  Created by Savely on 31.10.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var cleanPriceLabel: UILabel!
    @IBOutlet weak var fullPriceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var fromAdressLabel: UILabel!
    @IBOutlet weak var toAdressLabel: UILabel!
    @IBOutlet weak var timeStartLabel: UILabel!
    @IBOutlet weak var timeEndLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
