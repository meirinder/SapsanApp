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
        topLeftLabel.attributedText  = attributes?["topLeft"]?.content?.htmlToAttributedString
        if let hexColor =  attributes?["topLeft"]?.color {
            topLeftLabel.textColor = UIColor(hexString:hexColor)
        }
        if let BGHexColor =  attributes?["topLeft"]?.bgColor {
            topLeftLabel.backgroundColor = UIColor(hexString:BGHexColor)
        }
        
 
        botLeftLabel.attributedText = attributes?["botLeft"]?.content?.htmlToAttributedString
        if let hexColor =  attributes?["botLeft"]?.color {
            botLeftLabel.textColor = UIColor(hexString:hexColor)
        }
        if let BGHexColor =  attributes?["botLeft"]?.bgColor {
            botLeftLabel.backgroundColor = UIColor(hexString:BGHexColor)
        }
            
        topRightLabel.attributedText = attributes?["topRight"]?.content?.htmlToAttributedString
        topRightLabel.textAlignment = .right
        if let hexColor =  attributes?["topRight"]?.color {
            topRightLabel.textColor = UIColor(hexString:hexColor)
        }
        if let BGHexColor =  attributes?["topRight"]?.bgColor {
            topRightLabel.backgroundColor = UIColor(hexString:BGHexColor)
        }
        
        botRightLabel.attributedText = attributes?["botRight"]?.content?.htmlToAttributedString
        botRightLabel.textAlignment = .right
        if let hexColor =  attributes?["botRight"]?.color {
            botRightLabel.textColor = UIColor(hexString:hexColor)
        }
        if let BGHexColor =  attributes?["botRight"]?.bgColor {
            botRightLabel.backgroundColor = UIColor(hexString:BGHexColor)
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

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
