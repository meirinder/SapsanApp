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
    
    override func awakeFromNib() {
        let alert = Bundle.main.loadNibNamed("BalanceAlert", owner: self, options: nil)?.last as! BalanceAlertView
        alert.frame = UIScreen.main.bounds
        self.addSubview(alert)
        button.layer.cornerRadius = 6
    }
    
    @IBAction func buttonAction(_ sender: Any) {
    }
    
    
    
}
