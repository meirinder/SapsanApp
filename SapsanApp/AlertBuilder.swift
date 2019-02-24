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
        alert.frame = UIScreen.main.bounds
        lastWindow?.addSubview(alert)
    }
    
    
    
    
}
