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

    @IBOutlet weak private var rootStackView: UIStackView!
    @IBOutlet weak private var phoneTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var enterButton: UIButton!
    @IBOutlet weak private var recoverPasswoedButton: UIButton!
    @IBOutlet weak private var signUpButton: UIButton!
    
    var startViewModel = StartViewModel()
    
 
    private let phoneTextFieldBorder = CALayer()
    private let passTextFieldBorder = CALayer()
    private let navController = UINavigationController()
    private var menuCoordinator: MenuCoordinator!

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startViewModel.delegate = self
        addTapGestureToHideKeyboard()
        setTextFieldBorders()
        NotificationCenter.default.addObserver(self, selector: #selector(StartViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(StartViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        startViewModel.checkUserDefaults()
    }
    
    
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        view.endEditing(true)
        if segue.identifier == "enterSegue"{
            let nav = segue.destination as! UINavigationController
            let desVC = nav.topViewController as! OrdersViewController
            desVC.ordersViewModel = startViewModel.buildOrdersViewModel()
            desVC.ordersViewModel?.delegate = desVC
            Menu.viewControllers = [UIViewController]()
            Menu.viewControllers.append(desVC)
            let transactVC = self.storyboard?.instantiateViewController(withIdentifier: "TransactionViewController") as! TransactionViewController
            transactVC.transactionViewModel = TransactionViewModel()
            transactVC.transactionViewModel.delegate = transactVC 
            Menu.viewControllers.append(transactVC)
            
            let supportVC = self.storyboard?.instantiateViewController(withIdentifier: "SupportViewController") as! SupportViewController
            supportVC.supportViewModel = SupportViewModel()
            Menu.viewControllers.append(supportVC)
            
            Menu.menuViewModel = startViewModel.buildMenuViewModel()
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
    
    
    func log(phone: String, password: String) {
        if password.isEmpty {
            DispatchQueue.main.async {
                AlertBuilder.simpleAlert(title: "Ошибка", message: "Пустое поле логина или пароля", controller: self)
            }
        }
        startViewModel.enter(phoneText: phone, passText: password)
    }
    
    
    @IBAction func signIn(_ sender: UIButton) {
         log(phone: phoneTextField.text!, password: passwordTextField.text!)
    }
    

}

extension StartViewController {
    func setTextFieldBorders() {
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

extension StartViewController: UnlockAppDelegate{
    func loginApp() {
        DispatchQueue.main.async {
            self.menuCoordinator = MenuCoordinator(navController: self.navController, data: self.startViewModel.data)
            self.navigationController?.present(self.navController, animated: false, completion: nil)
            self.menuCoordinator.start()
//            self.performSegue(withIdentifier: "enterSegue", sender: self)
        }
    }
    
    func failure(text: String) {
        DispatchQueue.main.async {
            AlertBuilder.simpleAlert(title: "Ошибка", message: text, controller: self)
        }
    }
}

protocol UnlockAppDelegate: class {
    func loginApp()
    func failure(text: String)
}
