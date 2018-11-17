//
//  MenuViewController.swift
//  SapsanApp
//
//  Created by Savely on 30.10.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var dispatcherPhoneButton: UIButton!
    
    @IBOutlet weak var chooseCompanyButton: UIButton!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var dropDownMenuTableView: UITableView!
    
    @IBOutlet var test: UIView!
    static var loginData = LoginJSONStructure()

   
    
    
    let titles = ["Заказы","Транзакции","Поддержка"]
    var companies = [String]()
    static var txtColors = [UIColor(rgb: 0x1D2880), UIColor.white, UIColor.white]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backgroundImage = UIImage(named: "login_bg.jpg")
        let imageView = UIImageView(image: backgroundImage)
        self.menuTableView.backgroundView = imageView
        imageView.contentMode = .scaleAspectFill

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.delegate = self
        menuTableView.dataSource = self
        dropDownMenuTableView.isHidden = true
        for company in MenuViewController.loginData.userCompanies{
            companies.append(company.companyName!)
        }
        chooseCompanyButton.setTitle(MenuViewController.loginData.userCompanies[0].companyName, for: .normal)
        dispatcherPhoneButton.setTitle("+7"+MenuViewController.loginData.dispatcherPhone!, for: .normal)
    }
    
    @IBAction func makeDispatcherPhoneCall(_ sender: Any) {
        let url: NSURL = URL(string: "tel://\(String(describing: "+7"+MenuViewController.loginData.dispatcherPhone!))")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    

    func setLoginData(data: LoginJSONStructure) {
        MenuViewController.loginData = data
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
            cell.titleLabel.textColor = MenuViewController.txtColors[indexPath.row]
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
                
                
                
                MenuViewController.txtColors[0] = UIColor(rgb: 0x1D2880)
                MenuViewController.txtColors[1] = UIColor.white
                MenuViewController.txtColors[2] = UIColor.white
                menuTableView.reloadData()
                
                //performSegue(withIdentifier: "orderSegue", sender: self)
                break
            case 1:
                let detVC = self.storyboard?.instantiateViewController(withIdentifier: "TransactionViewController")
                self.navigationController?.pushViewController(detVC!, animated: true)
                
                MenuViewController.txtColors[0] = UIColor.white
                MenuViewController.txtColors[1] = UIColor(rgb: 0x1D2880)
                MenuViewController.txtColors[2] = UIColor.white
                menuTableView.reloadData()
                //performSegue(withIdentifier: "transactionSegue", sender: self)
                break
            case 2:
                let detVC = self.storyboard?.instantiateViewController(withIdentifier: "SupportViewController")
                self.navigationController?.pushViewController(detVC!, animated: true)
                
                MenuViewController.txtColors[0] = UIColor.white
                MenuViewController.txtColors[1] = UIColor.white
                MenuViewController.txtColors[2] = UIColor(rgb: 0x1D2880)
                menuTableView.reloadData()
                
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

