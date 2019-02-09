//
//  TransactionViewController.swift
//  SapsanApp
//
//  Created by Savely on 30.10.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import UIKit
 
class TransactionViewController: Menu, ReloadTableViewDelegate {
    
    

 
    var transactionViewModel: TransactionViewModel!
    
    
    @IBOutlet weak var transactionTableView: UITableView!
    
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTransactionTable), for: .valueChanged)
        // refreshControl.attributedTitle. = "Обновление заказов..."
        
        return refreshControl
    }()
    
    @objc func refreshTransactionTable(){
//        updateTransactionTable()
        refresher.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transactionViewModel.getTransactions()
        transactionTableView.refreshControl = refresher
        transactionTableView.delegate = self
        transactionTableView.dataSource = self
//        updateTransactionTable
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            if let tb = self.transactionTableView {
                 tb.reloadData()
            }
        }
    }

    @IBAction func menuBarButtonItem(_ sender: Any) {
        if AppDelegate.isMenuVC{
            showMenu()
        }else{
            hideMenu()
        }

    }
}

extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        
        return transactionViewModel.titleForHeader(index: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return transactionViewModel.sectionsCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionViewModel.transactionsInSectionCount(index: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = transactionTableView.dequeueReusableCell(withIdentifier: "transactionCell") as! TransactionTableViewCell
        cell.statusLabel.text = transactionViewModel.sum(section: indexPath.section, index: indexPath.row)
        cell.commentLabel.text = transactionViewModel.type(section: indexPath.section, index: indexPath.row)
        cell.statusLabel.backgroundColor = transactionViewModel.sumColor(section: indexPath.section, index: indexPath.row)
        return cell
    }
}

extension UIColor {
    convenience init(hexString:String) {
        let scanner = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
}
