//
//  TransactionViewController.swift
//  SapsanApp
//
//  Created by Savely on 30.10.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import UIKit

class TransactionViewController: Menu, UITableViewDelegate, UITableViewDataSource {
    
    var itemStore: [[TransactionItem]] = []
    var sections = [String]()
    static var loginData = LoginJSONStructure()
   // var outLoginData =  LoginJSONStructure()
    var transactions = ShortTransactions()
    let httpConnector = HTTPConnector()
    
    
    
    @IBOutlet weak var transactionTableView: UITableView!
    
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTransactionTable), for: .valueChanged)
        // refreshControl.attributedTitle. = "Обновление заказов..."
        
        return refreshControl
    }()
    
    @objc func refreshTransactionTable(){
        updateTransactionTable()
        refresher.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TransactionViewController.loginData = HomeViewController.loginData
        
        transactionTableView.refreshControl = refresher
        
        updateTransactionTable()


        
        
    }
    
    func  updateTransactionTable(){
        httpConnector.getTransactions(idCompany: TransactionViewController.loginData.userCompanies[0].idCompany!, idUser: TransactionViewController.loginData.userCompanies[0].idUser!, key: TransactionViewController.loginData.key!){ outTransactions in
            self.transactions = outTransactions
            self.sections = self.getDates(transactions: self.transactions)
            self.itemStore.removeAll()
            for _ in self.sections {
                self.itemStore.append([])
            }
            self.fillItemStore()
            DispatchQueue.main.async{
                self.transactionTableView.reloadData()
            }
        }
    }
    
    func fillItemStore(){
        for shortTransaction in transactions.shortTransactions {
            let item = TransactionItem(sum: shortTransaction.sum!, sumColor: shortTransaction.sumColor!, type: shortTransaction.type ?? "", comment: "")
            
            itemStore[findNeededDate(date: shortTransaction.date!)].append(item)
        }
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
    
    func getDates(transactions : ShortTransactions) -> [String] {
        var tmp = [String]()
        for shortTransaction in transactions.shortTransactions {
            tmp.append(shortTransaction.date!)
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
        
        return sections[section]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = transactionTableView.dequeueReusableCell(withIdentifier: "transactionCell") as! TransactionTableViewCell
        cell.statusLabel.text = itemStore[indexPath.section][indexPath.row].sum
        cell.commentLabel.text = itemStore[indexPath.section][indexPath.row].type
        if itemStore[indexPath.section][indexPath.row].sumColor == "#ff00C851" {
            cell.statusLabel.backgroundColor = UIColor(rgb: 0x00C851)
        }
        if itemStore[indexPath.section][indexPath.row].sumColor == "#ffff4444" {
            cell.statusLabel.backgroundColor = UIColor(rgb: 0xff4444)
        }
        
        return cell
    }

}
