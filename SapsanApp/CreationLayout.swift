//
//  CreationLayout.swift
//  SapsanApp
//
//  Created by Savely on 25/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class CreationOrderData {
    var balance: String?
    var status: String?
    var creationLayout: CreationLayout?
}

class CreationLayout {
    var blocks: [CreationBlock]?
}

class CreationBlock {
    var rows: [CreationRow]?
}

class WhenDropDownRow: CreationRow {
    var prefix = "Когда: "
    var label: String?
    var name: String?
    var items: [DropDownItem]?
}

class FromDropDownRow: CreationRow {
     var prefix = "Откуда: "
    var label: String?
    var name: String?
    var items: [DropDownItem]?
}

class DropDownItem {
    var id: String?
    var name: String?
}

class CreationRow {
    var type: String?
}

class DoubleDoubleGridRow: CreationRow {
    var topLeftText: CreationRowValue?
    var topRightText: CreationRowValue?
    var botLeftText: CreationRowValue?
    var botRightText: CreationRowValue?
}

class DoubleSoloGridRow: CreationRow {
    var leftText: CreationRowValue?
    var rightText: CreationRowValue?
}

class SoloGridRow: CreationRow {
    var value: CreationRowValue?
}

class DoubleCheckBoxesRow: CreationRow {
    var left: CreationRowValue?
    var right: CreationRowValue?
}

class CreationRowValue {
    var type: String?
    var label: String?
    var hint: String?
    var name: String?
    var keyboard_type: String?
}

class AdressEditRow: CreationRow {
     var label: String?
     var hint: String?
     var name: String?
}
