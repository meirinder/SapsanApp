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
        let attributes = fullOrderCellViewModel?.multiDict()
        leftKeyLabel.setHTMLFromString(text: attributes?["leftKey"]?.content ?? "")
        if let hexColor =  attributes?["leftKey"]?.color {
            leftKeyLabel.textColor = UIColor(hexString:hexColor)
        }
        if let BGHexColor =  attributes?["leftKey"]?.bgColor {
            leftKeyLabel.backgroundColor = UIColor(hexString:BGHexColor)
        }
        
        rightKeyLabel.setHTMLFromString(text: attributes?["rightKey"]?.content ?? "")
        if let hexColor =  attributes?["rightKey"]?.color {
            rightKeyLabel.textColor = UIColor(hexString:hexColor)
        }
        if let BGHexColor =  attributes?["rightKey"]?.bgColor {
            rightKeyLabel.backgroundColor = UIColor(hexString:BGHexColor)
        }
        
        if let typeOfValue = attributes?["leftValue"]?.type {
            if typeOfValue == "label" {
                leftValueButton.setHTMLFromString(text: attributes?["leftValue"]?.content ?? "")
                leftValueButton.layer.cornerRadius = 8
                if let hexColor =  attributes?["leftValue"]?.color {
                    leftValueButton.setTitleColor(UIColor(hexString:hexColor), for: .normal)
                }
                if let BGHexColor =  attributes?["leftValue"]?.bgColor {
                    leftValueButton.backgroundColor = UIColor(hexString:BGHexColor)
                }
            }
            if typeOfValue == "image" {
                if let content =  attributes?["leftValue"]?.content {
                    leftValueButton.setTitle("", for: .normal)
                    if let img = UIImage(named: content) {
                        let newImg = resizeImage(image: img, targetSize: CGSize(width: 20, height: 20))
                        rightValueButton.setImage(newImg, for: .normal)
                    }
                }
            }
        }
        
        if let typeOfValue = attributes?["rightValue"]?.type {
            if typeOfValue == "label" {
                rightValueButton.setHTMLFromString(text: attributes?["rightValue"]?.content ?? "")
                rightValueButton.layer.cornerRadius = 8
                if let hexColor = attributes?["rightValue"]?.color {
                    rightValueButton.setTitleColor(UIColor(hexString:hexColor), for: .normal)
                }
                if let BGHexColor = attributes?["rightValue"]?.bgColor {
                    rightValueButton.backgroundColor = UIColor(hexString:BGHexColor)
                }
            }
            if typeOfValue == "image" {
                if let content =  attributes?["rightValue"]?.content {
                    rightValueButton.setTitle("", for: .normal)
                    if let img = UIImage(named: content) {
                        let newImg = resizeImage(image: img, targetSize: CGSize(width: 20, height: 20))
                        rightValueButton.setImage(newImg, for: .normal)
                    }
                }
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

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}

