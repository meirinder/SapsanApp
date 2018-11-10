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
    var sections = ["12.04.2018", "11.04.2018", "10.04.2018"]
    var items : [OrderItem] = []
    var loginData = LoginJSONStructure()
    
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    
 
    
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
    
            return sections[section]
        }
    
        func numberOfSections(in tableView: UITableView) -> Int {
            return sections.count
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(loginData.status!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  ---------------------  test values
        let item1 = OrderItem(cleanPrice: "100",fullPrice: "200",status: "Выполнено",
                              timeStart: "12:30",timeEnd: "13:90",fromAdress: "Железнодорожная 72",toAdress: "Титова 10")
        let item2 = OrderItem(cleanPrice: "1040",fullPrice: "2030",status: "Выполнено",
                              timeStart: "16:30",timeEnd: "13:00",fromAdress: "Косолавая 7",toAdress: "Линейная 10")
        let item3 = OrderItem(cleanPrice: "110",fullPrice: "280",status: "Выполнено",
                              timeStart: "12:30",timeEnd: "13:00",fromAdress: "Пархоменко 72",toAdress: "Киевская 130")
        let item4 = OrderItem(cleanPrice: "150",fullPrice: "220",status: "Выполнено",
                              timeStart: "12:34",timeEnd: "13:00",fromAdress: "Трудовая 32",toAdress: "Фрунзе 101")
        let item5 = OrderItem(cleanPrice: "600",fullPrice: "700",status: "Выполнено",
                              timeStart: "12:30",timeEnd: "13:80",fromAdress: "Сельхозная 111",toAdress: "Титова 130")
        for _ in sections {
            itemStore.append([])
        }
        
        
        itemStore[0].append(item1)
        
        for item in items{
            itemStore[0].append(item)
        }

        
        itemStore[0].append(item2)
        itemStore[1].append(item3)
        itemStore[2].append(item4)
        itemStore[2].append(item5)

        //-------------------------
        
        
        
        orderTableView.delegate = self
        orderTableView.dataSource = self
    }
    
    

    
    @IBAction func menuBarButtonItem(_ sender: Any) {
        if AppDelegate.isMenuVC{
            showMenu()
        }else{
            hideMenu()
        }
        
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  100
    }
}

