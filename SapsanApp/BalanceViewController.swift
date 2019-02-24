//
//  BalanceViewController.swift
//  SapsanApp
//
//  Created by Savely on 26.11.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import UIKit

class BalanceViewController: Menu {

    
    @IBOutlet weak var balanceTextField: UITextField!
    
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func menuBarButtonItem(_ sender: Any) {
        if AppDelegate.isMenuVC{
            showMenu()
        }else{
            hideMenu()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BalanceUpSegue" {
            let vc = segue.destination as! SignUpViewController
            let companyId = UserDefaults.standard.object(forKey: "idCompany") as! String
            vc.link = "https://app.citycourier.pro/pay.php?id=\(companyId)&type=company&sum=\(balanceTextField.text ?? "0")"
        }
    }

}
