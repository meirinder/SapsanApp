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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://sapsan.cloud?app=ios"
        let myUrl = URL(string: url)
        let request = URLRequest(url: myUrl!)
        
        wk.load(request)
        // Do any additional setup after loading the view.
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
