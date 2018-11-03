//
//  aaaaatestsssViewController.swift
//  SapsanApp
//
//  Created by Savely on 03.11.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import UIKit

class aaaaatestsssViewController: UIViewController{
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var vc: UITableView!
    
    let texter = ["1","2","3","4","5","6","7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vc.isHidden = true
        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func onClick(_ sender: Any) {
        animate(toggle: vc.isHidden)
    }
    
    func animate (toggle: Bool) {
        if toggle{
            UIView.animate(withDuration: 0.3, animations: {
                self.vc.isHidden = false
                
            })
        }else{
            UIView.animate(withDuration: 0.3, animations: {
                self.vc.isHidden = true
    
            })
        }
    }
    
}

extension aaaaatestsssViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = vc.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        cell.textLabel?.text = texter[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        animate(toggle: false)
        button.setTitle(texter[indexPath.row], for: .normal)
    }
    
}
