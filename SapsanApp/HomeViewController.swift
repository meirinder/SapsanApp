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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  ---------------------  test values
//        let item1 = OrderItem(cleanPrice: "100",fullPrice: "200",status: "Выполнено",
//                              timeStart: "12:30",timeEnd: "13:90",fromAdress: "Железнодорожная 72",toAdress: "Титова 10")
//        let item2 = OrderItem(cleanPrice: "1040",fullPrice: "2030",status: "Выполнено",
//                              timeStart: "16:30",timeEnd: "13:00",fromAdress: "Косолавая 7",toAdress: "Линейная 10")
//        let item3 = OrderItem(cleanPrice: "110",fullPrice: "280",status: "Выполнено",
//                              timeStart: "12:30",timeEnd: "13:00",fromAdress: "Пархоменко 72",toAdress: "Киевская 130")
//        let item4 = OrderItem(cleanPrice: "150",fullPrice: "220",status: "Выполнено",
//                              timeStart: "12:34",timeEnd: "13:00",fromAdress: "Трудовая 32",toAdress: "Фрунзе 101")
//        let item5 = OrderItem(cleanPrice: "600",fullPrice: "700",status: "Выполнено",
//                              timeStart: "12:30",timeEnd: "13:80",fromAdress: "Сельхозная 111",toAdress: "Титова 130")
        
        
        
        
    //    itemStore[0].append(item1)
//
//        for item in items{
//            itemStore[0].append(item)
//        }

        
//        itemStore[0].append(item2)
//        itemStore[1].append(item3)
//        itemStore[2].append(item4)
//        itemStore[2].append(item5)

        //-------------------------
        if HomeViewController.loginData.status == nil{
            HomeViewController.loginData = outLoginData
        }
        updateOrderTable()
        
        
        orderTableView.delegate = self
        orderTableView.dataSource = self
    }
    
    func updateOrderTable() {
        httpConnector.getOrders(idCompany: HomeViewController.loginData.userCompanies[0].idCompany!, idUser: HomeViewController.loginData.userCompanies[0].idUser!, key: HomeViewController.loginData.key!){ outOrders in
            self.orders = outOrders
            self.sections = self.getDates(orders: self.orders)
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
        cell.cleanPriceLabel.text = itemStore[indexPath.section][indexPath.row].cleanPrice
        cell.fullPriceLabel.text = itemStore[indexPath.section][indexPath.row].fullPrice
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
