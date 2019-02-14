//
//  FullOrderViewModel.swift
//  SapsanApp
//
//  Created by Savely on 10/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class FullOrderViewModel: NSObject {

    var delegate: FullOrderDelegate?
    var orderId: String
    private var fullOrderData = FullOrderData()
    
    init(orderId: String) {
        self.orderId = orderId
    }
    
    func cellType(section: Int, index: Int) -> RowType {
        if let rowType = fullOrderData.fullOrderLayout?.blocks?[section].rows?[index].type {
            return rowType
        }
        return .none
    }
    
    func buildViewModelForCell(section: Int, index: Int) -> FullOrderCellViewModel {
        var result = FullOrderCellViewModel()
        if let row = fullOrderData.fullOrderLayout?.blocks?[section].rows?[index]{
            result = FullOrderCellViewModel(dataModel: row)
        }
        return result
    }
    
    func blocksCount() -> Int {
        return fullOrderData.fullOrderLayout?.blocks?.count ?? 0
    }
    
    func rowsCount(block: Int) -> Int {
        return fullOrderData.fullOrderLayout?.blocks?[block].rows?.count ?? 0
    }
//    
//    func viewsCount(block: Int, row: Int) -> Int {
//        return fullOrderData.fullOrderLayout?.blocks?[block].rows?[row].views?.count ?? 0
//    }
//    
//    func content(section: Int, row: Int, index: Int) -> String {
//        return fullOrderData.fullOrderLayout?.blocks?[section].rows?[row].views?[index].content ?? "errorContent"
//    }
//    
//    func cellType(section: Int, row: Int, index: Int) -> CellType {
//        switch fullOrderData.fullOrderLayout?.blocks?[section].rows?[row].views?[index].type {
//        case "label":
//            return .label
//        case "image":
//            return .image
//        case "checkbox":
//            return .checkBox
//        case "container":
//            return .container
//        default:
//            return .none
//        }
//    }
    
    func title() -> String {
        return ""
//        return "Заказ № " + (fullOrderData.fullOrderLayout?.orderNumber ?? "0")
    }
    
    func getMarkup() {
//        NetWorker.getFullOrders(idCompany: (UserDefaults.standard.object(forKey: "idCompany") as? String) ?? "",
//                                idUser: (UserDefaults.standard.object(forKey: "idUser") as? String)  ?? "",
//                                idOrder: orderId,
//                                key: (UserDefaults.standard.object(forKey: "key") as? String)  ?? "" ){ outData in
                                    self.fullOrderData = JSONWorker.parseFullOrdersInFile()
                                    self.delegate?.reloadViews()
//        }
    }
    
}

