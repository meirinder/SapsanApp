//
//  JSONWorker.swift
//  CityCourier
//
//  Created by Savely on 03/02/2019.
//  Copyright © 2019 CityCourier. All rights reserved.
//

import UIKit

class JSONWorker: NSObject {
    
    static func parseOrders(data: Data) -> OrdersData {
        let ordersData = OrdersData()
        let jsonResult  = try? JSONSerialization.jsonObject(with: data, options: [])
        if let dictionary = jsonResult as? [String: Any] {
            if let status = dictionary["status"] as? String {
                ordersData.status = status
            }
            if let balance = dictionary["balance"] as? String {
                ordersData.balance = balance
            }
            ordersData.ordersHeader = parseHeaderInfo(dictionarie: dictionary)
            ordersData.ratingCourier = parseCourierRating(dictioanrie: dictionary)
            ordersData.shortOrders = parseShortOrders(dictionarie: dictionary)
        }
        return ordersData
    }
    
    static private func parseShortOrders(dictionarie: [String: Any]) -> [ShortOrder] {
        var shortOrders = [ShortOrder]()
        if let orders = dictionarie["shortOrders"] as? [Any] {
            for i in 0..<orders.count {
                let localOrder = ShortOrder()
                if let order = orders[i] as? [String: Any] {
                    if let id = order["id"] as? String {
                        localOrder.id = id
                    }
                    if let deliveryTime = order["deliveryTime"] as? String {
                        localOrder.deliveryTime = deliveryTime
                    }
                    if let takeTime = order["takeTime"] as? String {
                        localOrder.takeTime = takeTime
                    }
                    if let companyMoney = order["companyMoney"] as? String {
                        localOrder.companyMoney = companyMoney
                    }
                    if let deliveryMoney = order["deliveryMoney"] as? String {
                        localOrder.deliveryMoney = deliveryMoney
                    }
                    if let statusText = order["statusText"] as? String {
                        localOrder.statusText = statusText
                    }
                    if let statusColor = order["statusColor"] as? String {
                        localOrder.statusColor = statusColor
                    }
                    if let addressFrom = order["addressFrom"] as? String {
                        localOrder.addressFrom = addressFrom
                    }
                    if let addressTo = order["addressTo"] as? String {
                        localOrder.addressTo = addressTo
                    }
                    if let date = order["date"] as? String {
                        localOrder.date = date
                    }
                }
                shortOrders.append(localOrder)
            }
        }
        return shortOrders
    }
    
    private static func parseCourierRating(dictioanrie: [String: Any]) -> RatingCourier {
        let ratingCourier = RatingCourier()
        if let localRat = dictioanrie["ratingCourier"] as? [String: Any] {
            if let idRatingRow = localRat["idRatingRow"] as? String {
                ratingCourier.idRatingRow = idRatingRow
            }
            if let name = localRat["name"] as? String {
                ratingCourier.name = name
            }
            if let photoUrl = localRat["photoUrl"] as? String {
                ratingCourier.photoUrl = photoUrl
            }
        }
        return ratingCourier
    }
    
    private static func parseHeaderInfo(dictionarie: [String: Any]) -> OrdersHeader {
        let ordersHeader = OrdersHeader()
        if let ordHeader = dictionarie["ordersHeader"] as? [String: Any] {
            if let header = ordHeader["header"] as? String {
                ordersHeader.header = header
            }
            if let body = ordHeader["body"] as? String {
                ordersHeader.body = body
            }
            if let textColor = ordHeader["textColor"] as? String {
                ordersHeader.textColor = textColor
            }
            if let bgColor = ordHeader["bgColor"] as? String {
                ordersHeader.bgColor = bgColor
            }
        }
        return ordersHeader
    }
    
    static func parseLoginData(data: Data) -> LoginData? {
        let jsonResult  = try? JSONSerialization.jsonObject(with: data, options: [])
        if let dictionary = jsonResult as? [String: Any] {
            if !checkErrorInLogin(dictionary: dictionary).0 {
                let loginData = LoginData()
                loginData.status = dictionary["status"] as? String
                loginData.errorText = checkErrorInLogin(dictionary: dictionary).text
                return loginData
            }
            //            loginDelegate?.successAction()
            return setLoginProperties(dictionarie: dictionary)
        }
        return nil
    }
    
    private static func setLoginProperties(dictionarie: [String: Any]) -> LoginData {
        let loginData = LoginData()
        if let status = dictionarie["status"] as? String {
            loginData.status = status
        }
        if let key = dictionarie["key"] as? String {
            loginData.key = key
        }
        if let dispatcherPhone = dictionarie["dispatcherPhone"] as? String {
            loginData.dispatcherPhone = dispatcherPhone
        }
        if let balance = dictionarie["balance"] as? String {
            loginData.balance = balance
        }
        loginData.supportInfo = parseLoginSupportInfo(dictionarie: dictionarie)
        loginData.userCompanies = parseLoginUserCompanies(dictionarie: dictionarie)
        return loginData
    }
    
    private static func parseLoginUserCompanies(dictionarie: [String: Any]) -> [UserCompanie] {
        var userCompanies = [UserCompanie]()
        if let companies = dictionarie["userCompanies"] as? [Any] {
            for i in 0..<companies.count {
                if let company = companies[i] as? [String: Any]{
                    let localCompany = UserCompanie()
                    if let idUser = company["idUser"] as? String {
                        localCompany.idUser = idUser
                    }
                    if let idCompany = company["idCompany"] as? String {
                        localCompany.idCompany = idCompany
                    }
                    if let name = company["name"] as? String {
                        localCompany.name = name
                    }
                    if let companyName = company["companyName"] as? String {
                        localCompany.companyName = companyName
                    }
                    if let idUserCity = company["idUserCity"] as? String {
                        localCompany.idUserCity = idUserCity
                    }
                    userCompanies.append(localCompany)
                }
            }
        }
        return userCompanies
    }
    
    private static func parseLoginSupportInfo(dictionarie: [String: Any]) -> SupportInfo{
        let supportInfo = SupportInfo()
        if let suppInfo = dictionarie["support_info"] as? [String: Any] {
            if let name  = suppInfo["name"] as? String {
                supportInfo.name = name
            }
            if let eMail = suppInfo["email"] as? String {
                supportInfo.eMail = eMail
            }
            if let phone = suppInfo["phone"] as? String {
                supportInfo.phone = phone
            }
        }
        return supportInfo
    }
    
    
    private static func checkErrorInLogin(dictionary: [String: Any]) -> (Bool, text: String?) {
        if let status = dictionary["status"]{
            if ((status as? String) == "ERROR"){
                if dictionary["errorText"] != nil {
                    return (false, dictionary["errorText"] as? String)
                }
            }
        } else {
            return  (false, "UnknownError")
        }
        return (true,"OK")
    }
}

protocol LogInDelegate: class {
    func failureAction(errorText: String)
    func successAction()
}
