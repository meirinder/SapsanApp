//
//  shortOrders.swift
//  
//
//  Created by Savely on 10.11.2018.
//

import Foundation

struct ShortOrders : Decodable {
    var id : String?
    var deliveryTime : String?
    var takeTime : String?
    var companyMoney : String?
    var deliveryMoney : String?
    var statusText : String?
    var statusColor : String?
    var addressFrom : String?
    var addressTo : String?
    var date : String?
}

struct OrderStructure : Decodable{
    var shortOrders = [ShortOrders]()
    var status : String?
}
