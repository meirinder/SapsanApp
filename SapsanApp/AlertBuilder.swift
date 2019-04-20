//
//  AlertBuilder.swift
//  SapsanApp
//
//  Created by Savely on 06/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class AlertBuilder: NSObject {

    static func simpleAlert(title: String, message: String, controller: UIViewController,
                            completion: @escaping () -> () = {}) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                completion()
         }))
        controller.present(alert, animated: true)
    }
    
    static func balanceAlert(controller: UIViewController) {
        let alert = Bundle.main.loadNibNamed("BalanceAlert", owner: self, options: nil)?.last as! BalanceAlertView
        alert.controller = controller
        alert.setTextFieldBorders()
        let windows = UIApplication.shared.windows
        let lastWindow = windows.last
        alert.frame = UIScreen.main.bounds
        lastWindow?.addSubview(alert)
    }
    
    static func supportAlert(controller: UIViewController, helpTypes: [HelpTypes]) {
        let alert = Bundle.main.loadNibNamed("SupportAlert", owner: self, options: nil)?.last as! SupportAlertView
        alert.controller = controller
        alert.helpTypes = helpTypes
        let windows = UIApplication.shared.windows
        let lastWindow = windows.last
        alert.frame = UIScreen.main.bounds
        lastWindow?.addSubview(alert)
    }
    
    static func courierAlert(name: String, photoLink: String, controller: UIViewController) {
        let alert = Bundle.main.loadNibNamed("CourierAlert", owner: self, options: nil)?.last as! CourierView
        alert.nameLabel.text = name
        alert.controller = controller
        alert.setTextFieldBorders()
        alert.photoImageView.downloaded(from: photoLink)
        let windows = UIApplication.shared.windows
        let lastWindow = windows.last
        alert.frame = UIScreen.main.bounds 
        lastWindow?.addSubview(alert)
    }
 
    static func deleteAlert(title: String, message: String, controller: UIViewController, completion: @escaping (String) -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Причина удалиния (обязательно)"
        }
        alert.addAction(UIAlertAction(title: "Удалить", style: .default, handler: { (action) in
            if !alert.textFields!.first!.text!.isEmpty {
                completion(alert.textFields?.first?.text ?? "")
            }
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.default, handler: { action in
        }))
        
        
        controller.present(alert, animated: true)
    }
    
    
}
