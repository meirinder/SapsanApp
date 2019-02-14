//
//  HeaderDetailViewController.swift
//  SapsanApp
//
//  Created by Savely on 10/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class HeaderDetailViewController: UIViewController {

    @IBOutlet weak var headerTextView: UITextView!
    
    var headerText: String!
    var headerBGColor: UIColor!
    var headerTextColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerTextView.backgroundColor = headerBGColor
        headerTextView.textColor = headerTextColor
        headerTextView.text = headerText
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
