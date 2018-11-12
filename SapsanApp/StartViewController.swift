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
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var loginData = LoginJSONStructure()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(StartViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(StartViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enterSegue"{
            let nav = segue.destination as! UINavigationController
            let desVC = nav.topViewController as! HomeViewController
            desVC.outLoginData = self.loginData
            let controller = storyboard!.instantiateViewController(withIdentifier: "MenuVC") as! MenuViewController
            controller.setLoginData(data: self.loginData)

        }
    }
    
    
    func logIn()  {
        if loginData.status == "OK"{
            self.performSegue(withIdentifier: "enterSegue", sender: self)
        }else{
            let ac = UIAlertController(title: "Ошибка", message: "Неверный логин или пароль", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                print("OK!")
            }
            ac.addAction(okAction)
            self.present(ac, animated: true)
        }
    }
  
    
    @IBAction func signIn(_ sender: Any) {   // Input button Processing
       
        let httpConnector = HTTPConnector()
        httpConnector.login(phone: phoneTextField.text!, password: passwordTextField.text!){ outLoginData in
            self.loginData = outLoginData
            DispatchQueue.main.async{
                self.logIn()
            }
        }
        
        
        
    }
    

}

extension UIViewController {
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height/2
            }
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height/2
            }
        }
    }
}
