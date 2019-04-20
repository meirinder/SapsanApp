//
//  AlertBuilder.swift
//  SapsanApp
//
//  Created by Savely on 06/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class AlertBuilder: NSObject {

    static func simpleAlert(title: String, message: String, controller: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
         }))
        controller.present(alert, animated: true)
    }
    
    static func courierAlert(name: String, photoLink: String, controller: UIViewController) {
        let alert = Bundle.main.loadNibNamed("CourierAlert", owner: self, options: nil)?.last as! CourierView
        alert.nameLabel.text = name
        alert.controller = controller
        alert.setTextFieldBorders()
        alert.photoImageView.downloaded(from: photoLink)
        let windows = UIApplication.shared.windows
        let lastWindow = windows.last
        alert.frame = UIScreen.main.bounds//CGRect(x: 40, y: 40, width: alert.frame.width, height: alert.frame.height)//
//        let backView = UIView(frame: UIScreen.main.bounds)
//        backView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
//        lastWindow?.addSubview(backView)
        lastWindow?.addSubview(alert)
    }
    
    static func errorAlert(status: String, controller: UINavigationController) {
        
    }
    
    static func deleteAlert(title: String, message: String, controller: UIViewController, completion: @escaping (String) -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Причина удалиния"
        }
        alert.addAction(UIAlertAction(title: "Удалить", style: .default, handler: { (action) in
            completion(alert.textFields?.first?.text ?? "")
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.default, handler: { action in
        }))
        
        
        controller.present(alert, animated: true)
    }
    
    
}
