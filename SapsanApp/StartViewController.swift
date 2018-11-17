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
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.68
        view.layer.cornerRadius = 10.0
        return view
    }()
    private func pinBackground(_ view: UIView, to stackView: UIStackView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(view, at: 0)
        view.pin(to: stackView)
    }
    
    var loginData = LoginJSONStructure()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
 
        pinBackground(backgroundView, to: rootStackView)
        
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
  
    
    @IBAction func signIn(_ sender: Any) {   
       
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

public extension UIView {
    public func pin(to view: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}
