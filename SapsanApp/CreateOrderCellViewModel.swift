//
//  CreateOrderCellViewModel.swift
//  SapsanApp
//
//  Created by Savely on 13/03/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class CreateOrderCellViewModel {

    private var row: CreationRow
    
    var dict = [String: String?] ()
    
    func quatroDict() -> [String: String?] {
        let localRow = row as! DoubleDoubleGridRow
        let topLeftText = localRow.topLeftText
        let topRightText = localRow.topRightText
        let botLeftText = localRow.botLeftText
        let botRightText = localRow.botRightText

         dict = ["topLeftTextHint": topLeftText?.hint, "topLeftTextKeyboard_type":  topLeftText?.keyboard_type,
                "topLeftTextLabel": topLeftText?.label, "topLeftTextName": topLeftText?.name,
                "topRightTextHint": topRightText?.hint, "topRightTextKeyboard_type":  topRightText?.keyboard_type,
                "topRightTextLabel": topRightText?.label, "topRightTextName": topRightText?.name,
                "botLeftTextHint": botLeftText?.hint, "botLeftTextKeyboard_type":  botLeftText?.keyboard_type,
                "botLeftTextLabel": botLeftText?.label, "botLeftTextName": botLeftText?.name,
                "botRightTextHint": botRightText?.hint, "botRightTextKeyboard_type":  botRightText?.keyboard_type,
                "botRightTextLabel": botRightText?.label, "botRightTextName": botRightText?.name]
        return dict
    }
    
    func dropDownRow() -> CreationRow {
         return row
    }
    
    func doubleDict() -> [String: String?] {
        let localRow = row as! DoubleSoloGridRow
        let leftText = localRow.leftText
        let rightText = localRow.rightText
        dict = ["leftTextHint": leftText?.hint, "leftTextKeyboard_type":  leftText?.keyboard_type,
                "leftTextLabel": leftText?.label, "leftTextName": leftText?.name,
                "rightTextHint": rightText?.hint, "rightTextKeyboard_type":  rightText?.keyboard_type,
                "rightTextLabel": rightText?.label, "rightTextName": rightText?.name]
        return dict
    }
    
    func addressDict() -> [String: String?] {
        let localRow = row as! AdressEditRow
        let dict = ["hint": localRow.hint, "label": localRow.label ,"name": localRow.name]
        return dict
    }
    
    func soloDict() -> [String: String?] {
        let localRow = row as! SoloGridRow
        let value = localRow.value
        dict = ["hint": value?.hint, "keyboard_type":  value?.keyboard_type, "label": value?.label, "name": value?.name]
        return dict
    }
    
    init(row: CreationRow) {
        self.row = row
    }
    
    
}
