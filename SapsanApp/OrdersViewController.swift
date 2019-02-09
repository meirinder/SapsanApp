//
//  HomeViewController.swift
//  SapsanApp
//
//  Created by Savely on 29.10.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//


import UIKit

class OrdersViewController: Menu, UITableViewDataSource, UITableViewDelegate {

//    var itemStore : [[OrderItem]] = []
    
    var ordersViewModel: OrdersViewModel?{
        didSet {
            ordersViewModel?.getOrders()
        }
    }

    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!




//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        print(OrdersViewController.loginData.status!)
//
//    }


    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshOrderTable), for: .valueChanged)
       // refreshControl.attributedTitle. = "Обновление заказов..."
        
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderTableView.refreshControl = refresher
        orderTableView.delegate = self
        orderTableView.dataSource = self
    }


    @objc func refreshOrderTable(){
        ordersViewModel?.getOrders()
        refresher.endRefreshing()
    }


   

    func getDates(orders : OrdersData) -> [String] {
        var tmp = [String]()
        if let shortOrders = orders.shortOrders{
            for shortOrder in shortOrders {
                tmp.append(shortOrder.date!)
            }
        }
        return tmp.removeDuplicates()
    }

    

    @IBAction func menuBarButtonItem(_ sender: Any) {
        if AppDelegate.isMenuVC{
            showMenu()
        }else{
            hideMenu()
        }
        
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        
        return ordersViewModel?.titleForHeader(index: section) ?? ""
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return ordersViewModel?.sectionsCount() ?? 0
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersViewModel?.ordersInSectionCount(index: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderTableView.dequeueReusableCell(withIdentifier: "OrderCell") as! OrderTableViewCell
        cell.cleanPriceLabel.text = ordersViewModel?.cleanPrice(section: indexPath.section, index: indexPath.row)
        cell.fullPriceLabel.text = ordersViewModel?.fullPrice(section: indexPath.section, index: indexPath.row)
        cell.statusLabel.text = ordersViewModel?.status(section: indexPath.section, index: indexPath.row)
        cell.timeStartLabel.text = ordersViewModel?.timeStart(section: indexPath.section, index: indexPath.row)
        cell.timeEndLabel.text = ordersViewModel?.timeEnd(section: indexPath.section, index: indexPath.row)
        cell.fromAdressLabel.text = ordersViewModel?.fromAddress(section: indexPath.section, index: indexPath.row)
        cell.toAdressLabel.text = ordersViewModel?.toAddress(section: indexPath.section, index: indexPath.row)
        cell.statusLabel.backgroundColor = ordersViewModel?.statusColor(section: indexPath.section, index: indexPath.row)
 
        
        

        
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

extension OrdersViewController: ReloadTableViewDelegate {
    func reloadTableView() {
        DispatchQueue.main.async {
            if let tableView = self.orderTableView {
                tableView.reloadData()
            }
        }
    }
}

protocol ReloadTableViewDelegate: class {
    func reloadTableView()
}
