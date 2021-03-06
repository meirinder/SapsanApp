//
//  HomeViewController.swift
//  SapsanApp
//
//  Created by Savely on 29.10.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//


import UIKit

class OrdersViewController: Menu, UITableViewDataSource, UITableViewDelegate {

 
    var ordersViewModel: OrdersViewModel?{
        didSet {
            ordersViewModel?.getOrders(first: 0, count: 20)
        }
    }

    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    

 


    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshOrderTable), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Обновление заказов...")
        refreshControl.layer.zPosition = -1
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        JSONWorker.navigationController = self.navigationController!
        AlertBuilder.courierAlert(name: "Классный пацанчик", photoLink: "333", controller: self)
        
        orderTableView.refreshControl = refresher
        orderTableView.delegate = self
        orderTableView.dataSource = self
     }


    @objc func refreshOrderTable(){
        JSONWorker.navigationController = self.navigationController!
        ordersViewModel?.getOrders(first: 0, count: 20)
    }

    private func setHeaderText() {
        headerLabel.text = ordersViewModel?.headerText()
        headerLabel.backgroundColor = ordersViewModel?.headerBGColor()
        headerLabel.textColor = ordersViewModel?.headerTextColor()
        detailsLabel.backgroundColor = ordersViewModel?.headerBGColor()
        detailsLabel.textColor = ordersViewModel?.headerTextColor()
        headerView.backgroundColor = ordersViewModel?.headerBGColor()
        self.detailsLabel.text = "Подробности"
    }
    
    @IBAction func infoAction(_ sender: UIButton) {
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "headerSegue" {
            let vc = segue.destination as! HeaderDetailViewController
            vc.headerText = ordersViewModel?.headerBodyText()
            vc.headerBGColor = ordersViewModel?.headerBGColor()
            vc.headerTextColor = ordersViewModel?.headerTextColor()
        }
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

    
    @IBAction func createOrderAction(_ sender: UIBarButtonItem) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateOrderViewController") as? CreateOrderViewController
        vc?.viewModel = CreateOrderViewModel()
        self.hideMenu()
        self.navigationController?.pushViewController(vc!, animated: true)
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
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            orderTableView.tableHeaderView = headerView
            orderTableView.layoutIfNeeded()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersViewModel?.ordersInSectionCount(index: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ((indexPath.section == ordersViewModel?.sectionsCount() ?? 0 - 1) && (indexPath.row == ordersViewModel?.ordersInSectionCount(index: ordersViewModel?.sectionsCount() ?? 0 - 1) ?? 0 - 1)) {
            JSONWorker.navigationController = self.navigationController!
            ordersViewModel?.getOrders(first: ordersViewModel?.ordersCount() ?? 0, count: 20)
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fullorderViewModel = FullOrderViewModel(orderId: ordersViewModel?.orderId(section: indexPath.section, index: indexPath.row) ?? "")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FullOrderViewController") as? FullOrderViewController
        vc?.fullOrderViewModel = fullorderViewModel
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
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
            self.setHeaderText() 
            if self.refresher.isRefreshing {
                self.refresher.endRefreshing()
            }
            if let tableView = self.orderTableView {
                tableView.reloadData()
            }
        }
    }
}

protocol ReloadTableViewDelegate: class {
    func reloadTableView()
}
