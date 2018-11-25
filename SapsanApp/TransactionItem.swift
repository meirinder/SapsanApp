//
//  TransactionItem.swift
//  SapsanApp
//
//  Created by Savely on 25.11.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import UIKit

class TransactionItem: NSObject {
    var sum: String
    var sumColor: String
    var type: String
    var comment: String
    
    
    
    init(sum: String, sumColor: String, type: String, comment: String) {
        self.sum = sum
        self.sumColor = sumColor
        self.type = type
        self.comment = comment
    }
}
