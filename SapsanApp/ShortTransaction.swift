//
//  ShortTransaction.swift
//  SapsanApp
//
//  Created by Savely on 25.11.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import Foundation


struct shortTransaction : Decodable{
    var id: String?
    var sum: String?
    var type: String?
    var sumColor: String?
    var orderId: String?
    var comment: String?
    var date: String?
}

struct ShortTransactions: Decodable {
    var shortTransactions = [shortTransaction]()
}
