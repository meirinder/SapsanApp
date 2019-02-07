//
//  TransactionViewModel.swift
//  SapsanApp
//
//  Created by Savely on 05/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class TransactionViewModel: NSObject {
    private var sections = [String]()
    private var transactionData = TransactionData() {
        didSet {
            fillItemStore()
        }
    }
    private var itemStore = [[ShortTransaction]]()
    weak var delegate: ReloadTableViewDelegate?
    
    
    
    func transactionsInSectionCount(index: Int) -> Int {
        return itemStore[index].count
    }
    
    func sectionsCount() -> Int {
        return sections.count
    }
    
    func titleForHeader(index: Int) -> String {
        return sections[index]
    }
    
    func sum(section: Int, index: Int) -> String {
        return (itemStore[section][index].sum) ?? "errorSum" + " ₽"
    }
    
    func type(section: Int, index: Int) -> String {
        return (itemStore[section][index].type) ?? "errorType"
    }
    
    func sumColor(section: Int, index: Int) -> UIColor {
        var color = itemStore[section][index].sumColor?.dropFirst(3) ?? "ffffff"
        color = "#" + color
        return UIColor(hexString: String(color))
    }
    
    private func fillItemStore() {
        itemStore.removeAll()
        sections.removeAll()
        var date = ""
        var count = -1
        if let shortTransactions = transactionData.shortTransactions {
            for i in 0..<shortTransactions.count {
                let shortTransaction = shortTransactions[i]
                if date != shortTransaction.date {
                    date = shortTransaction.date ?? "errorDate"
                    sections.append(date)
                    count += 1
                    itemStore.append([ShortTransaction]())
                }
                itemStore[count].append(shortTransaction)
            }
        }
    }
    
    func getTransactions() {
        NetWorker.getTransactions(idCompany: (UserDefaults.standard.object(forKey: "idCompany") as? String) ?? "",
                            idUser: (UserDefaults.standard.object(forKey: "idUser") as? String) ?? "",
                            key: (UserDefaults.standard.object(forKey: "key") as? String) ?? "") { outData in
                                self.transactionData = JSONWorker.parseTransactions(data: outData)
                                self.delegate?.reloadTableView()
        }
    }
}
