//
//  HomeViewController.swift
//  SapsanApp
//
//  Created by Savely on 29.10.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//


import UIKit

class HomeViewController: Menu, UITableViewDelegate, UITableViewDataSource {
    
    var itemStore : [[OrderItem]] = []
    var sections = [String]()
    static var loginData = LoginJSONStructure()
    var outLoginData =  LoginJSONStructure()
    var orders = OrderStructure()
    let httpConnector = HTTPConnector()
    
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
   
 
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(HomeViewController.loginData.status!)
        
    }
    
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshOrderTable), for: .valueChanged)
       // refreshControl.attributedTitle. = "Обновление заказов..."
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        orderTableView.refreshControl = refresher
        

        
        if HomeViewController.loginData.status == nil{
            HomeViewController.loginData = outLoginData
        }
        updateOrderTable()
        
        
        orderTableView.delegate = self
        orderTableView.dataSource = self
    }
    
    
    @objc func refreshOrderTable(){
        updateOrderTable()
        refresher.endRefreshing()
    }
    
    
    func updateOrderTable() {
        httpConnector.getOrders(idCompany: HomeViewController.loginData.userCompanies[0].idCompany!, idUser: HomeViewController.loginData.userCompanies[0].idUser!, key: HomeViewController.loginData.key!){ outOrders in
            self.orders = outOrders
            if self.orders.status == "NO_ACCESS"{
                DispatchQueue.main.async {
                    
                    let ac = UIAlertController(title: "Ошибка", message: "Кто-то другой зашел под вашим логином", preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                        UserDefaults.standard.removeObject(forKey: "loginData")
                        self.performSegue(withIdentifier: "exitSegue", sender: self)
                        print("OK!")
                    }
                    ac.addAction(okAction)
                    self.present(ac, animated: true)
                }
            }
            self.sections = self.getDates(orders: self.orders)
            self.itemStore.removeAll()
            for _ in self.sections {
                self.itemStore.append([])
            }
            self.fillItemStore(orders: self.orders)
            DispatchQueue.main.async{
                self.orderTableView.reloadData()
            }
        }
    }
    
    func getDates(orders : OrderStructure) -> [String] {
        var tmp = [String]()
        for shortOrder in orders.shortOrders {
            tmp.append(shortOrder.date!)
        }
        
        return tmp.removeDuplicates()
    }
    
    func findNeededDate(date : String)-> Int{
        var res = 0;
        for section in  sections {
            if date == section{
                return res
            }
            res += 1
        }
        return -1
    }
    
    func fillItemStore(orders : OrderStructure){
        for shortOrder in orders.shortOrders {
            let item = OrderItem(cleanPrice: shortOrder.companyMoney! ,fullPrice: shortOrder.deliveryMoney!,status: shortOrder.statusText!,timeStart:shortOrder.takeTime!,timeEnd: shortOrder.deliveryTime!,fromAdress: shortOrder.addressFrom!,toAdress: shortOrder.addressTo!,statusColor: shortOrder.statusColor!)
        
            itemStore[findNeededDate(date: shortOrder.date!)].append(item)
        }
    }
    
    
    
    @IBAction func menuBarButtonItem(_ sender: Any) {
        if AppDelegate.isMenuVC{
            showMenu()
        }else{
            hideMenu()
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        
        return sections[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderTableView.dequeueReusableCell(withIdentifier: "OrderCell") as! OrderTableViewCell
        cell.cleanPriceLabel.text = itemStore[indexPath.section][indexPath.row].cleanPrice + " ₽"
        cell.fullPriceLabel.text = itemStore[indexPath.section][indexPath.row].fullPrice + " ₽"
        cell.statusLabel.text = itemStore[indexPath.section][indexPath.row].status
        cell.timeStartLabel.text = itemStore[indexPath.section][indexPath.row].timeStart
        cell.timeEndLabel.text = itemStore[indexPath.section][indexPath.row].timeEnd
        cell.fromAdressLabel.text = itemStore[indexPath.section][indexPath.row].fromAdress
        cell.toAdressLabel.text = itemStore[indexPath.section][indexPath.row].toAdress
        if itemStore[indexPath.section][indexPath.row].statusColor == "#ff44aa44" {
            cell.statusLabel.backgroundColor = UIColor(rgb: 0x44aa44)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  100
    }
}

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}
extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
