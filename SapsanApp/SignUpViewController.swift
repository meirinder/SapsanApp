//
//  SignUpViewController.swift
//  SapsanApp
//
//  Created by Savely on 29.10.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import UIKit
import WebKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var wk: WKWebView!

     var link = "https://sapsan.cloud?app=ios"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)

       
        reloadView()
        // Do any additional setup after loading the view.
    }
    
    func reloadView() {
        DispatchQueue.main.async {
            if let url = URL(string: self.link) {
                let request = URLRequest(url: url) 
                self.wk.load(request)
            } else {
                AlertBuilder.simpleAlert(title: "Ошибка", message: "Что-то пошло не так, свяжитесь с менеджером", controller: self)
            }
        }
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
