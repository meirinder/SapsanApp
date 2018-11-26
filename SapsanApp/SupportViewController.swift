//
//  SupportViewController.swift
//  SapsanApp
//
//  Created by Savely on 03.11.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import UIKit

class SupportViewController: Menu {

    
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    static var loginData = LoginJSONStructure()
    var outLoginData =  LoginJSONStructure()

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if SupportViewController.loginData.status == nil{
            SupportViewController.loginData = outLoginData
        }
        
        nameLabel.text = " " + (SupportViewController.loginData.support_info?.name!)!
        emailLabel.text = SupportViewController.loginData.support_info?.email
        phoneLabel.text = "+7 (" + formatPhone()
        
        
        // Do any additional setup after loading the view.
    }
    
    func formatPhone() -> String {
        var phoneNumber = SupportViewController.loginData.support_info?.phone!
        var startThree = phoneNumber!.dropLast(7)
        startThree += ") "
        var nextThree = phoneNumber!.dropLast(4)
        nextThree = nextThree.dropFirst(3)
        nextThree += "-"
        var nextTwo = phoneNumber!.dropLast(2)
        nextTwo = nextTwo.dropFirst(6)
        nextTwo += "-"
        return String(startThree+nextThree+nextTwo+(phoneNumber?.dropFirst(8))!)
    }
    
    @IBAction func menuBarButtonItem(_ sender: Any) {
        if AppDelegate.isMenuVC{
            showMenu()
        }else{
            hideMenu()
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
