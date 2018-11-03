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
    
    
    override init() {
        self.cleanPrice = ""
        self.fullPrice = ""
        self.status = ""
        self.timeStart = ""
        self.timeEnd = ""
        self.fromAdress = ""
        self.toAdress = ""
    }
    
    
    init(cleanPrice: String, fullPrice: String,status : String,timeStart: String,timeEnd: String,fromAdress: String,toAdress: String) {
        self.cleanPrice = cleanPrice
        self.fullPrice = fullPrice
        self.status = status
        self.timeStart = timeStart
        self.timeEnd = timeEnd
        self.fromAdress = fromAdress
        self.toAdress = toAdress
    }
}
