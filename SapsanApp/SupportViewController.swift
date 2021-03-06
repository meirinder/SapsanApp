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
    
    
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    var supportViewModel: SupportViewModel!

    
    @IBAction func phoneAction(_ sender: UIButton) {
        let url: NSURL = URL(string: "tel://\(String(describing: "+7" + supportViewModel.phone()))")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func instructionAction(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        NetWorker.instructionLink(completion: { outLink in
            DispatchQueue.main.async {
                vc.link = outLink
                self.navigationController?.pushViewController(vc, animated: true)
            }
        })
    }
    
    @IBAction func writeSupportAction(_ sender: UIButton) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WriteSupportViewController") as! WriteSupportViewController
//        vc.helpTypes = supportViewModel.getTypes()
//        self.navigationController?.present(vc, animated: true, completion: nil)  //pushViewController(vc, animated: true)
        AlertBuilder.supportAlert(controller: self, helpTypes: supportViewModel.getTypes()!)
    }
    
    @IBAction func emailAction(_ sender: UIButton) {
        let address = supportViewModel.email()
        if let url = URL(string: "mailto:\(address)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JSONWorker.navigationController = self.navigationController!
        supportViewModel.getInstructions()
        
        // Do any additional setup after loading the view.
    }
    
    func updateInfo() {
        supportViewModel.getInfo()
        
        nameLabel.text = " " + supportViewModel.name()
        emailButton.setTitle(supportViewModel.email(), for: .normal)
        phoneButton.setTitle("+7 (" + formatPhone(), for: .normal)
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
    
    
    

}
