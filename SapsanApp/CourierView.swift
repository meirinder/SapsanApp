//
//  CourierView.swift
//  SapsanApp
//
//  Created by Savely on 24/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class CourierView: UIView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    weak var controller: UIViewController!
    private let commentTextFieldBorder = CALayer()

    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var ratingSegmentController: UISegmentedControl!
    @IBAction func ratingAction(_ sender: Any) {
        if ratingSegmentController.selectedSegmentIndex != -1 {
            print( ratingSegmentController.selectedSegmentIndex)
            self.removeFromSuperview()
        } else {
            AlertBuilder.simpleAlert(title: "Упс", message: "Вы забыли указать оценку", controller: controller)
        }
        
    }
    @IBAction func unratingAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
   
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension CourierView {
    @IBAction func startEditingTextField(_ sender: UITextField) {
        commentTextFieldBorder.borderColor = UIColor(rgb: 0x1D2880).cgColor
    }
    
    @IBAction func endEditingTextField(_ sender: UITextField) {
        commentTextFieldBorder.borderColor = UIColor.darkGray.cgColor
    }
    
    func setTextFieldBorders() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
        self.addGestureRecognizer(tapGesture)
        let width = CGFloat(1.0)
        commentTextFieldBorder.borderColor = UIColor.darkGray.cgColor
        commentTextFieldBorder.frame = CGRect(x: 0, y: commentTextField.frame.size.height - width, width: self.bounds.width + 64, height: commentTextField.frame.size.height)
        commentTextFieldBorder.borderWidth = width
        commentTextField.layer.addSublayer(commentTextFieldBorder)
        commentTextField.layer.masksToBounds = true
    }
}
