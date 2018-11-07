//
//  MenuViewController.swift
//  SapsanApp
//
//  Created by Savely on 30.10.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {


    @IBOutlet weak var chooseCompanyButton: UIButton!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var dropDownMenuTableView: UITableView!
    
    
    
    
    let titles = ["Заказы","Транзакции","Поддержка"]
    let companies = ["1","2","3","4","5","6","7"]
    let txtColors = [UIColor.white, UIColor.white, UIColor.white]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backgroundImage = UIImage(named: "login_bg.jpg")
        let imageView = UIImageView(image: backgroundImage)
        self.menuTableView.backgroundView = imageView
     //   menuTableView.tableFooterView = UIView(frame)
        imageView.contentMode = .scaleAspectFill


        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.delegate = self
        menuTableView.dataSource = self
        dropDownMenuTableView.isHidden = true
        
    }
    

    
    @IBAction func onClicChooseCompanyButton(_ sender: Any) {
        animate(toggle: dropDownMenuTableView.isHidden)
    }
    
    func animate (toggle: Bool) {
        if toggle{
            UIView.animate(withDuration: 0.3, animations: {
                self.dropDownMenuTableView.isHidden = false
                
            })
        }else{
            UIView.animate(withDuration: 0.3, animations: {
                self.dropDownMenuTableView.isHidden = true
                
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.menuTableView{
            return titles.count
        }
        if tableView == self.dropDownMenuTableView{
            return companies.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.menuTableView{
            let cell = menuTableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuTableViewCell
            cell.titleLabel.text = titles[indexPath.row]
            cell.titleLabel.textColor = txtColors[indexPath.row]
            return cell
        }
        if tableView == self.dropDownMenuTableView{
            let cell = dropDownMenuTableView.dequeueReusableCell(withIdentifier: "DropDownCell", for: indexPath)
            cell.textLabel?.text = companies[indexPath.row]
            return cell
        }
        let cell = MenuTableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.menuTableView{
            return 60;
        }
        return 40
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.menuTableView{
            switch indexPath.row {
            case 0:
                let detVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
                self.navigationController?.pushViewController(detVC!, animated: true)
                //performSegue(withIdentifier: "orderSegue", sender: self)
                break
            case 1:
                let detVC = self.storyboard?.instantiateViewController(withIdentifier: "TransactionViewController")
                self.navigationController?.pushViewController(detVC!, animated: true)
                //performSegue(withIdentifier: "transactionSegue", sender: self)
                break
            case 2:
                let detVC = self.storyboard?.instantiateViewController(withIdentifier: "SupportViewController")
                self.navigationController?.pushViewController(detVC!, animated: true)
                
                //performSegue(withIdentifier: "supportSegue", sender: self)
            default: break
            }
        }
        if tableView == self.dropDownMenuTableView{
            animate(toggle: false)
            chooseCompanyButton.setTitle(companies[indexPath.row], for: .normal)
        }

    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        
    }
    
}
