//
//  RecoverPasswordViewController.swift
//  SapsanApp
//
//  Created by Savely on 29.10.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import UIKit
import AKMaskField

class RecoverPasswordViewController: UIViewController  {

    
    @IBOutlet weak var recoveryTextField: AKMaskField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func recoveryAction(_ sender: UIButton) {
        NetWorker.recoveryPass(phone: recoveryTextField.text ?? "errorText" ){ outData in
            
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
