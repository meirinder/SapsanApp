//
//  TransactionViewController.swift
//  SapsanApp
//
//  Created by Savely on 30.10.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import UIKit

class TransactionViewController: Menu {

    
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    
  //  var menuVC :MenuViewController!
    
    override func viewWillAppear(_ animated: Bool) {
        showMenu()
        hideMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func menuBarButtonItem(_ sender: Any) {
        if AppDelegate.isMenuVC{
            showMenu()
        }else{
            hideMenu()
        }

    }

    

}
