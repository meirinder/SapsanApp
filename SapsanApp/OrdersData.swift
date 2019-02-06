//
//  OrdersData.swift
//  CityCourier
//
//  Created by Savely on 03/02/2019.
//  Copyright © 2019 CityCourier. All rights reserved.
//


class OrdersData {
    var balance: String?
    var status: String?
    var shortOrders: [ShortOrder]?
    var ordersHeader: OrdersHeader?
    var ratingCourier: RatingCourier?
}

class RatingCourier {
    var idRatingRow: String?
    var name: String?
    var photoUrl: String?
}

class OrdersHeader {
    var header: String?
    var body: String?
    var textColor: String?
    var bgColor: String?
}

class ShortOrder {
    var id: String?
    var deliveryTime: String?
    var takeTime: String?
    var companyMoney: String?
    var deliveryMoney: String?
    var statusText: String?
    var statusColor: String?
    var addressFrom: String?
    var addressTo: String?
    var date: String?
}

