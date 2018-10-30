//
//  StartViewController.swift
//  SapsanApp
//
//  Created by Savely on 29.10.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import UIKit
import AKMaskField

class StartViewController: UIViewController {

    
    
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var recoverPasswoedButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signIn(_ sender: Any) {   // Input button Processing
       // if (phoneTextField.text == "+7 (913) 450-53-53") && (passwordTextField.text == "12345"){
            performSegue(withIdentifier: "enterSegue", sender: self)
      //  }else{
      //      print("Incorrect login or password")
     //   }
        

        
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
