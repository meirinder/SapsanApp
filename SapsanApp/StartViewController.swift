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

    
    
    @IBOutlet weak var rootStackView: UIStackView!
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var recoverPasswoedButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    var loginData = LoginJSONStructure()
    
    let phoneTextFieldBorder = CALayer()
    let passTextFieldBorder = CALayer()
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
        
        

        
        print(enterButton.titleLabel?.font)
        let width = CGFloat(1.0)
        
        
        phoneTextFieldBorder.borderColor = UIColor.darkGray.cgColor
        phoneTextFieldBorder.frame = CGRect(x: 0, y: phoneTextField.frame.size.height - width, width: phoneTextField.frame.size.width, height: phoneTextField.frame.size.height)
        
        phoneTextFieldBorder.borderWidth = width
        
        phoneTextField.layer.addSublayer(phoneTextFieldBorder)
        phoneTextField.layer.masksToBounds = true
        
        
        
        passTextFieldBorder.borderColor = UIColor.darkGray.cgColor
        passTextFieldBorder.frame = CGRect(x: 0, y: passwordTextField.frame.size.height - width, width: passwordTextField.frame.size.width, height: passwordTextField.frame.size.height)
        
        passTextFieldBorder.borderWidth = width
       
        passwordTextField.layer.addSublayer(passTextFieldBorder)
        passwordTextField.layer.masksToBounds = true
 
        
        NotificationCenter.default.addObserver(self, selector: #selector(StartViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(StartViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         view.endEditing(true)
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
            if self.view.frame.origin.y < 0{
                print(self.view.frame.origin.y)
                print("Hide")
                self.view.frame.origin.y = 0
            }
            let ac = UIAlertController(title: "Ошибка", message: "Неверный логин или пароль", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                print("OK!")
            }
            ac.addAction(okAction)
            self.present(ac, animated: true)
        }
    }
  
    
    
    
    @IBAction func startEditingTextField(_ sender: UITextField) {
        if sender == phoneTextField{
            phoneTextFieldBorder.borderColor = UIColor(rgb: 0x1D2880).cgColor
        } else if sender == passwordTextField{
            passTextFieldBorder.borderColor = UIColor(rgb:0x1D2880).cgColor
        }
    }
    
    @IBAction func endEditingTextField(_ sender: UITextField) {
        if sender == phoneTextField{
            phoneTextFieldBorder.borderColor = UIColor.darkGray.cgColor
        } else if sender == passwordTextField{
            passTextFieldBorder.borderColor = UIColor.darkGray.cgColor
        }
    }
    
    
    @IBAction func signIn(_ sender: UIButton) {
        print(sender.titleLabel?.font)
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
            if self.view.frame.origin.y >= 0{
                print(self.view.frame.origin.y)
                print("Show")
                self.view.frame.origin.y -= keyboardSize.height/2
            }
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y < 0{
                print(self.view.frame.origin.y)
                print("Hide")
                self.view.frame.origin.y = 0
            }
        }
    }
}

