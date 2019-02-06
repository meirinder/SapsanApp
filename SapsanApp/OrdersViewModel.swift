//
//  OrdersViewModel.swift
//  SapsanApp
//
//  Created by Savely on 05/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class OrdersViewModel: NSObject {
    
    private var sections = [String]()
    private var ordersData = OrdersData() {
        didSet {
            fillItemStore()
        }
    }
    private var itemStore = [[ShortOrder]]()
    weak var delegate: ReloadTableViewDelegate?

    private func fillItemStore() {
        itemStore.removeAll()
        sections.removeAll()
        var date = ""
        var count = -1
        if let shortOrders = ordersData.shortOrders {
            for i in 0..<shortOrders.count {
                let shortOrder = shortOrders[i]
                if date != shortOrder.date {
                    date = shortOrder.date ?? "errorDate"
                    sections.append(date)
                    count += 1
                    itemStore.append([ShortOrder]())
                }
                itemStore[count].append(shortOrder)
            }
        }
    }
    
    
    
    func cleanPrice(section: Int, index: Int) -> String {
        return (itemStore[section][index].companyMoney ?? "error") + " ₽"
    }
    
    func fullPrice(section: Int, index: Int) -> String {
        return (itemStore[section][index].deliveryMoney ?? "error") + " ₽"
    }
    
    func statusColor(section: Int, index: Int) -> String {
        return itemStore[section][index].statusColor ?? ""
    }
    
    func status(section: Int, index: Int) -> String {
        return itemStore[section][index].statusText ?? "error"
    }
    
    func timeStart(section: Int, index: Int) -> String {
        return itemStore[section][index].takeTime ?? "error"
    }
    
    func timeEnd(section: Int, index: Int) -> String {
        return itemStore[section][index].deliveryTime ?? "error"
    }
    
    func fromAddress(section: Int, index: Int) -> String {
        return itemStore[section][index].addressFrom ?? "error"
    }
    
    func toAddress(section: Int, index: Int) -> String {
        return itemStore[section][index].addressTo ?? "error"
    }
    
    func ordersInSectionCount(index: Int) -> Int {
        return itemStore[index].count ?? 0
    }
    
    func sectionsCount() -> Int {
        return sections.count
    }
    
    func titleForHeader(index: Int) -> String {
        return sections[index]
    }
    
    func getOrders() {
        NetWorker.getOrders(idCompany: (UserDefaults.standard.object(forKey: "idCompany") as? String) ?? "",
                            idUser: (UserDefaults.standard.object(forKey: "idUser") as? String) ?? "",
                            key: (UserDefaults.standard.object(forKey: "key") as? String) ?? "") { outData in
                                self.ordersData = JSONWorker.parseOrders(data: outData)
                                self.delegate?.reloadTableView()
        }
    }
    
//    func findNeededDate(date : String)-> Int{
//        var res = 0;
//        for section in  sections {
//            if date == section{
//                return res
//            }
//            res += 1
//        }
//        return -1
//    }
    
}
