//
//  BalanceViewController.swift
//  SapsanApp
//
//  Created by Savely on 26.11.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import UIKit

class BalanceViewController: Menu {

    
    
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

}
