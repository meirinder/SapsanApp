//
//  CreateOrderViewController.swift
//  SapsanApp
//
//  Created by Savely on 07.11.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import UIKit

class CreateOrderViewController: UIViewController {
    
    
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toStreetTextField: UITextField!
    @IBOutlet weak var toHouseNumberTextField: UITextField!
    @IBOutlet weak var PriceTextField: UITextField!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(StartViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(StartViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

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
