//
//  FullOrderCellViewModel.swift
//  SapsanApp
//
//  Created by Savely on 14/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class FullOrderCellViewModel {
    var dataModel: Row
    
    func quatroDict() -> [String: RowValue] {
        var resDict = [String: RowValue]()
        let data = dataModel as? QuatroRow
        resDict["topLeft"] = data?.topLeftText
        resDict["botLeft"] = data?.botLeftText
        resDict["topRight"] = data?.topRightText
        resDict["botRight"] = data?.botRightText
        return resDict
    }
    
    func multiDict() -> [String: RowValue] {
        var resDict = [String: RowValue]()
        let data = dataModel as? MultiRow
        resDict["leftKey"] = data?.leftKeyText
        resDict["leftValue"] = data?.leftValueText
        resDict["rightKey"] = data?.rightKeyText
        resDict["rightValue"] = data?.rightValueText
        return resDict
    }
    
    func courierDict() -> [String: RowValue] {
        var resDict = [String: RowValue]()
        let data = dataModel as? CourierRow
        resDict["photoLink"] = data?.photoLink
        resDict["nameText"] = data?.nameText
        resDict["phoneText"] = data?.phoneText
        return resDict
    }
    
    func doubleDict() -> [String: RowValue] {
        var resDict = [String: RowValue]()
        let data = dataModel as? DoubleRow
        resDict["top"] = data?.topText
        resDict["bot"] = data?.botText
        return resDict
    }
    
    
    init() {
        dataModel = Row()
    }
    
    init(dataModel: Row) {
        self.dataModel = dataModel
    }
    
    
}
