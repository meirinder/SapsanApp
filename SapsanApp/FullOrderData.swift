//
//  FullOrderData.swift
//  SapsanApp
//
//  Created by Savely on 12/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class FullOrderData {
    var fullOrderLayout: FullOrderLayout?
    var balance: String?
    var status: String?
}

class FullOrderLayout {
    var orderNumber: String?
    var orderId: String?
    var showDeleteButton: Bool?
    var deleteButtonText: String?
    var blocks: [Block]?
}

class Block {
    var rows: [Row]?
}

class Row {
    var type: RowType?
}

class QuatroRow: Row {
    var topLeftText: RowValue?
    var topRightText: RowValue?
    var botLeftText: RowValue?
    var botRightText: RowValue?
}

class CourierRow: Row {
    var photoLink: RowValue?
    var nameText: RowValue?
    var phoneText: RowValue?
}

class DoubleRow: Row {
    var topText: RowValue?
    var botText: RowValue?
}

class MultiRow: Row {
    var leftKeyText: RowValue?
    var leftValueText: RowValue?
    var rightKeyText: RowValue?
    var rightValueText: RowValue?
}

class RowValue {
    var type: String?
    var content: String?
    var color: String?
    var bgColor: String?
}



enum RowType{
    case quatro
    case courier
    case double
    case multi
    case none
}
