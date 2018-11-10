//
//  OrderItem.swift
//  SapsanApp
//
//  Created by Savely on 31.10.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import UIKit

class OrderItem: NSObject {

    var cleanPrice: String
    var fullPrice: String
    var status : String
    var timeStart: String
    var timeEnd: String
    var fromAdress: String
    var toAdress: String
    var statusColor : String
    
    override init() {
        self.cleanPrice = ""
        self.fullPrice = ""
        self.status = ""
        self.timeStart = ""
        self.timeEnd = ""
        self.fromAdress = ""
        self.toAdress = ""
        self.statusColor = ""
    }
    
    
    init(cleanPrice: String, fullPrice: String,status : String,timeStart: String,timeEnd: String,fromAdress: String,toAdress: String, statusColor: String) {
        self.cleanPrice = cleanPrice
        self.fullPrice = fullPrice
        self.status = status
        self.timeStart = timeStart
        self.timeEnd = timeEnd
        self.fromAdress = fromAdress
        self.toAdress = toAdress
        self.statusColor = statusColor
    }
}
