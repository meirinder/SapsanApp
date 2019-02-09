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
    
    var supportViewModel: SupportViewModel!

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func updateInfo() {
        supportViewModel.getInfo()
        
        nameLabel.text = " " + supportViewModel.name()
        emailLabel.text = supportViewModel.email()
        phoneLabel.text = "+7 (" + formatPhone()
    }
    
    func formatPhone() -> String {
        let phoneNumber = supportViewModel.phone()
        var startThree = phoneNumber.dropLast(7)
        startThree += ") "
        var nextThree = phoneNumber.dropLast(4)
        nextThree = nextThree.dropFirst(3)
        nextThree += "-"
        var nextTwo = phoneNumber.dropLast(2)
        nextTwo = nextTwo.dropFirst(6)
        nextTwo += "-"
        return String(startThree+nextThree+nextTwo+(phoneNumber.dropFirst(8)))
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
