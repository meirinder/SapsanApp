//
//  TransactionData.swift
//  SapsanApp
//
//  Created by Savely on 07/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class TransactionData: NSObject {
    var shortTransactions: [ShortTransaction]?
    var balance: String?
    var status: String?
}

class ShortTransaction {
    var id: String?
    var sum: String?
    var type: String?
    var balanceAfter: String?
    var sumColor: String?
    var orderId: String?
    var comment: String?
    var date: String?
}
