//
//  BalanceAlertView.swift
//  SapsanApp
//
//  Created by Savely on 20/04/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class BalanceAlertView: UIView {
    @IBOutlet weak var balanceTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    
    
    weak var controller: UIViewController!
    private let balanceTextFieldBorder = CALayer()

     
    @IBAction func dismissAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    override func awakeFromNib() {
         button.layer.cornerRadius = 6
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        let companyId = UserDefaults.standard.object(forKey: "idCompany") as! String
        vc.link = "https://app.citycourier.pro/pay.php?id=\(companyId)&type=company&sum=\(balanceTextField.text ?? "0")"
        self.removeFromSuperview()
        controller.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setTextFieldBorders() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
        self.addGestureRecognizer(tapGesture)
        let width = CGFloat(1.0)
        balanceTextFieldBorder.borderColor = UIColor.clear.cgColor
        balanceTextFieldBorder.frame = CGRect(x: 0, y: balanceTextField.frame.size.height - width, width: self.bounds.width + 64, height: balanceTextField.frame.size.height)
        balanceTextFieldBorder.borderWidth = width
        balanceTextField.layer.addSublayer(balanceTextFieldBorder)
        balanceTextField.layer.masksToBounds = true
    }
    
}


