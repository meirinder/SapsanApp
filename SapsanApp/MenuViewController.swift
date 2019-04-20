//
//  MenuViewController.swift
//  SapsanApp
//
//  Created by Savely on 30.10.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var dispatcherPhoneButton: UIButton!
//    static var currentCompany = 0
    static var currentMenu = 0
    @IBOutlet weak var chooseCompanyButton: UIButton!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var dropDownMenuTableView: UITableView!
    @IBOutlet weak var balanceButton: UIButton!
    
//    static var viewControllers: [UIViewController]!
    var menuDelgate: Menu!
    weak var delegate: EventHadlerDelegate?
    
    var loginData: LoginData!
//    var httpConnector = HTTPConnector()
//    
//    
//    @IBOutlet var test: UIView!
//    static var loginData = LoginJSONStructure()
    
    @IBOutlet weak var userNameLabel: UILabel!

       @IBOutlet weak var backgroundImageView: UIImageView!

    
    let titles = ["Заказы","Транзакции","Поддержка"]
    var companies = [String]()
    static var txtColors = [UIColor(rgb: 0x1D2880), UIColor.black, UIColor.black]

   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setBalance()
        switch MenuViewController.currentMenu {
        case 0:
            MenuViewController.txtColors[0] = UIColor(rgb: 0x1D2880)
            MenuViewController.txtColors[1] = UIColor.black
            MenuViewController.txtColors[2] = UIColor.black
            break
        case 1:
            MenuViewController.txtColors[0] = UIColor.black
            MenuViewController.txtColors[1] = UIColor(rgb: 0x1D2880)
            MenuViewController.txtColors[2] = UIColor.black
            break
        case 2:
            MenuViewController.txtColors[0] = UIColor.black
            MenuViewController.txtColors[1] = UIColor.black
            MenuViewController.txtColors[2] = UIColor(rgb: 0x1D2880)
            break
        default:
            break
        }
        let currentCompany = UserDefaults.standard.object(forKey: "currentCompany") as? Int ?? 0
        let companyName = "  " + (loginData.userCompanies?[currentCompany].companyName!)! + "  "
        chooseCompanyButton.setTitle(companyName, for: .normal)
        menuTableView.reloadData()
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBalance()


        menuTableView.delegate = self
        menuTableView.dataSource = self
        dropDownMenuTableView.isHidden = true
        for company in loginData!.userCompanies! {
            companies.append(company.companyName!)
        }
        
        let currentCompany = UserDefaults.standard.object(forKey: "currentCompany") as? Int ?? 0
        userNameLabel.text = "  " +  (loginData.userCompanies?[currentCompany].name!)! + "  "
        
        dispatcherPhoneButton.setTitle("+7 ("+formatPhone(), for: .normal)
    }

    @IBAction func makeDispatcherPhoneCall(_ sender: Any) {
        let url: NSURL = URL(string: "tel://\(String(describing: "+7" + loginData.dispatcherPhone!))")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }

    
    func formatPhone() -> String {
        let phoneNumber = loginData.dispatcherPhone!
        var startThree = phoneNumber.dropLast(7)
        startThree += ") "
        var nextThree = phoneNumber.dropLast(4)
        nextThree = nextThree.dropFirst(3)
        nextThree += "-"
        var nextTwo = phoneNumber.dropLast(2)
        nextTwo = nextTwo.dropFirst(6)
        nextTwo += "-"
        return String(startThree+nextThree+nextTwo+phoneNumber.dropFirst(8))
    }

  
    
     @IBAction func onClicChooseCompanyButton(_ sender: Any) {
        animate(toggle: dropDownMenuTableView.isHidden)
    }

    func animate (toggle: Bool) {
        if toggle{
             self.dropDownMenuTableView.isHidden = false
          }else{
            self.dropDownMenuTableView.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.menuTableView{
            return titles.count
        }
        if tableView == self.dropDownMenuTableView{
            return companies.count - 1
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
            let currentCompany = UserDefaults.standard.object(forKey: "currentCompany") as? Int ?? 0
            if indexPath.row >= currentCompany {
                cell.textLabel?.text = companies[indexPath.row + 1]
            } else {
                cell.textLabel?.text = companies[indexPath.row]
            }
            return cell
        }
        let cell = MenuTableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if tableView == self.menuTableView{
//            return 60;
//        }
        return 40
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.menuTableView {
            switch indexPath.row {
            case 0:
                
                if MenuViewController.currentMenu == 0 {
                    menuDelgate.hideMenu()
                } else {
                    delegate?.handleEvent(event: .orders)
                }
                
                MenuViewController.currentMenu = 0
                break
            case 1:
                if MenuViewController.currentMenu == 1 {
                    menuDelgate.hideMenu()
                } else {
                    delegate?.handleEvent(event: .transactions)

                }
                MenuViewController.currentMenu = 1
                break
            case 2:
                
                if MenuViewController.currentMenu == 2 {
                    menuDelgate.hideMenu()
                } else {
                    delegate?.handleEvent(event: .support)
                }
                
                MenuViewController.currentMenu = 2
            default: break
            }
        }
        if tableView == self.dropDownMenuTableView{
            animate(toggle: false)
            let currentCompany = UserDefaults.standard.object(forKey: "currentCompany") as? Int ?? 0
            if indexPath.row >= currentCompany {
                chooseCompanyButton.setTitle("  " + companies[indexPath.row + 1] + "  ", for: .normal)
                NetWorker.changeUser(newIdCompany: loginData.userCompanies?[indexPath.row + 1].idCompany ?? "", newIdUser: loginData.userCompanies?[indexPath.row + 1].idUser ?? ""  ) {data in
                    JSONWorker.navigationController = self.navigationController  ?? UINavigationController()
                    let newData = JSONWorker.parseLoginData(data: data)
                    Menu.menuViewModel.loginData.supportInfo = newData?.supportInfo
                    Menu.menuViewModel.loginData.key = newData?.key
                    Menu.menuViewModel.loginData.dispatcherPhone = newData?.dispatcherPhone
                    Menu.menuViewModel.loginData.balance = newData?.balance
                    DataBaseWorker.saveLoginData(loginData: Menu.menuViewModel.loginData)
                    UserDefaults.standard.set(newData?.key, forKey: "key")
                    UserDefaults.standard.set(self.loginData.userCompanies?[indexPath.row + 1].idCompany, forKey: "idCompany")
                    UserDefaults.standard.set(self.loginData.userCompanies?[indexPath.row + 1].idUser, forKey: "idUser")
                    UserDefaults.standard.set(newData?.balance, forKey: "balance")
                    self.setBalance()
                    
                    self.delegate?.handleEvent(event: .changeUser)
                }
                UserDefaults.standard.set(indexPath.row + 1, forKey: "currentCompany")
            } else {
                chooseCompanyButton.setTitle("  " + companies[indexPath.row] + "  ", for: .normal)
                NetWorker.changeUser(newIdCompany: loginData.userCompanies?[indexPath.row].idCompany ?? "", newIdUser: loginData.userCompanies?[indexPath.row].idUser ?? ""  ) { data in
                    JSONWorker.navigationController = self.navigationController!
                    let newData = JSONWorker.parseLoginData(data: data)
                    Menu.menuViewModel.loginData.supportInfo = newData?.supportInfo
                    Menu.menuViewModel.loginData.key = newData?.key
                    Menu.menuViewModel.loginData.dispatcherPhone = newData?.dispatcherPhone
                    Menu.menuViewModel.loginData.balance = newData?.balance
                    DataBaseWorker.saveLoginData(loginData: Menu.menuViewModel.loginData)
                    UserDefaults.standard.set(newData?.key, forKey: "key")
                    UserDefaults.standard.set(self.loginData.userCompanies?[indexPath.row].idCompany, forKey: "idCompany")
                    UserDefaults.standard.set(self.loginData.userCompanies?[indexPath.row].idUser, forKey: "idUser")
                    UserDefaults.standard.set(newData?.balance, forKey: "balance")
                    self.setBalance()
                    
                    self.delegate?.handleEvent(event: .changeUser)
                }
                UserDefaults.standard.set(indexPath.row, forKey: "currentCompany")
            }
            
            DispatchQueue.main.async {
                self.dropDownMenuTableView.reloadData()
            }
//            MenuViewController.currentCompany = indexPath.row
        }

    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        
    }
    
    
    @IBAction func exit(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "key")
        DataBaseWorker.deleteAll()
    }

    @IBAction func balanceAction(_ sender: UIButton) {
        delegate?.handleEvent(event: .balance)
    }

    func setBalance() {
        DispatchQueue.main.async {
             self.balanceButton.setTitle(((UserDefaults.standard.object(forKey: "balance")) as? String), for: .normal)
        }
    }
    
}

