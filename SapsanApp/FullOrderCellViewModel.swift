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
    
    
    init() {
        dataModel = Row()
    }
    
    init(dataModel: Row) {
        self.dataModel = dataModel
    }
    
    
}
