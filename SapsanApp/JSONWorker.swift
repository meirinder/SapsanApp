//
//  JSONWorker.swift
//  CityCourier
//
//  Created by Savely on 03/02/2019.
//  Copyright © 2019 CityCourier. All rights reserved.
//

import UIKit

class JSONWorker: NSObject {
    
    
    static func parseFullOrdersInFile() -> FullOrderData{
        let fullOrderData = FullOrderData()
        if let path = Bundle.main.path(forResource: "FullOrder", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult  = try? JSONSerialization.jsonObject(with: data, options: [])
                if let dictionary = jsonResult as? [String: Any] {
                    if let status = dictionary["status"] as? String {
                        fullOrderData.status = status
                    }
                    if let balance = dictionary["balance"] as? String {
                        fullOrderData.balance = balance
                        UserDefaults.standard.set(balance, forKey: "balance")
                    }
                    fullOrderData.fullOrderLayout = parseFullOrderLayput(dictionary: dictionary)
                }
            } catch {
        // handle error
            }
    
        }
        return fullOrderData
    }
    
    private static func parseFullOrderLayput(dictionary: [String: Any]) -> FullOrderLayout {
        let fullLayout = FullOrderLayout()
        let test = dictionary["fullOrderLayout"] as? [String: Any]
         if let localLayout = test {
            if let orderNumber = localLayout["orderNumber"] as? String? {
                fullLayout.orderNumber = orderNumber
            }
            if let orderId = localLayout["orderId"] as? String? {
                fullLayout.orderId = orderId
            }
            if let showDeleteButton = localLayout["showDeleteButton"] as? Bool? {
                fullLayout.showDeleteButton = showDeleteButton
            }
            if let deleteButtonText = localLayout["deleteButtonText"] as? String? {
                fullLayout.deleteButtonText = deleteButtonText
            }
            fullLayout.blocks = parseBlocks(dictionary: localLayout)
        }
        return fullLayout
    }
    
    private static func parseBlocks(dictionary: [String: Any]) -> [Block] {
        var blocks = [Block]()
        if let localBlocks = dictionary["blocks"] as? [Any] {
            for i in 0..<localBlocks.count {
                let block = Block()
                if let localBlock = localBlocks[i] as? [String: Any] {
                    block.rows = parseRows(dictionary: localBlock)
                }
                blocks.append(block)
            }
        }
        return blocks
    }
    
    private static func parseRows(dictionary: [String: Any]) -> [Row] {
        var rows = [Row]()
        if let localRows = dictionary["rows"] as? [Any] {
            for i in 0..<localRows.count {
                
                if let localRow = localRows[i] as? [String: Any] {
                    switch rowType(dict: localRow){
                    case .double:
                        let row = DoubleRow()
                        if let topText = localRow["top"] as? [String: Any] {
                            row.topText = parseRowValue(dict: topText)
                        }
                        if let botText = localRow["bottom"] as? [String: Any] {
                            row.botText = parseRowValue(dict: botText)
                        }
                        row.type = rowType(dict: localRow)
                        rows.append(row)
                        break
                    case .multi:
                        let row = MultiRow()
                        
                        row.type = rowType(dict: localRow)
                        rows.append(row)
                        break
                    case .quatro:
                        let row = QuatroRow()
                        if let topLeftText = localRow["left_top"] as? [String: Any] {
                            row.topLeftText = parseRowValue(dict: topLeftText)
                        }
                        if let topRightText = localRow["right_top"] as? [String: Any] {
                            row.topRightText = parseRowValue(dict: topRightText)
                        }
                        if let botLeftText = localRow["left_bottom"] as? [String: Any] {
                            row.botLeftText = parseRowValue(dict: botLeftText)
                        }
                        if let botRightText = localRow["right_bottom"] as? [String: Any] {
                            row.botRightText = parseRowValue(dict: botRightText)
                        }
                        row.type = rowType(dict: localRow)
                        rows.append(row)
                        break
                    case .none:
                        let row = Row()
                        row.type = rowType(dict: localRow)
                        rows.append(row)
                        break
                    }
                    
                }
            }
        }
        return rows
    }
    
    private static func parseRowValue(dict: [String: Any]) -> RowValue {
        let rowValue = RowValue()
        if let type = dict["type"] as? String {
            rowValue.type = type
        }
        if let content = dict["content"] as? String {
            rowValue.content = content
        }
        return rowValue
    }
    
    private static func rowType(dict: [String: Any]) -> RowType {
        if let type = dict["type"] as? String {
            switch type {
            case "4_in_a_row":
                return .multi
            case "1x2_grid":
                return .double
            case "2x2_grid":
                return .quatro
            default:
                return .none
            }
        }
        return .none
    }
    
    static func parseTransactions(data: Data) -> TransactionData {
        let transactionsData = TransactionData()
        let jsonResult  = try? JSONSerialization.jsonObject(with: data, options: [])
        if let dictionary = jsonResult as? [String: Any] {
            if let status = dictionary["status"] as? String {
                transactionsData.status = status
            }
            if let balance = dictionary["balance"] as? String {
                transactionsData.balance = balance
                UserDefaults.standard.set(balance, forKey: "balance")
            }
            transactionsData.shortTransactions = parseShortTransactions(dictionary: dictionary)
        }
        return transactionsData
    }
    
    static private func parseShortTransactions(dictionary: [String: Any]) -> [ShortTransaction] {
        var shortTransactions = [ShortTransaction]()
        if let transactions = dictionary["shortTransactions"] as? [Any] {
            for i in 0..<transactions.count {
                let localTransaction = ShortTransaction()
                if let transaction = transactions[i] as? [String: Any] {
                    if let id = transaction["id"] as? String {
                        localTransaction.id = id
                    }
                    if let sum = transaction["sum"] as? String {
                        localTransaction.sum = sum
                    }
                    if let type = transaction["type"] as? String {
                        localTransaction.type = type
                    }
                    if let balanceAfter = transaction["balanceAfter"] as? String {
                        localTransaction.balanceAfter = balanceAfter
                    }
                    if let sumColor = transaction["sumColor"] as? String {
                        localTransaction.sumColor = sumColor
                    }
                    if let orderId = transaction["orderId"] as? String {
                        localTransaction.orderId = orderId
                    }
                    if let comment = transaction["comment"] as? String {
                        localTransaction.comment = comment
                    }
                    if let date = transaction["date"] as? String {
                        localTransaction.date = date
                    }
                    
                }
                shortTransactions.append(localTransaction)
            }
        }
        
        return shortTransactions
    }
    
    static func parseOrders(data: Data) -> OrdersData {
        let ordersData = OrdersData()
        let jsonResult  = try? JSONSerialization.jsonObject(with: data, options: [])
        if let dictionary = jsonResult as? [String: Any] {
            if let status = dictionary["status"] as? String {
                ordersData.status = status
            }
            if let balance = dictionary["balance"] as? String {
                ordersData.balance = balance
                UserDefaults.standard.set(balance, forKey: "balance")
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
            let outData = setLoginProperties(dictionarie: dictionary)
            DataBaseWorker.saveLoginData(loginData: outData)
            return outData
        }
        return nil
    }
    
    static func parseSignUp(data: Data) -> String {
        var resString = ""
        let jsonResult  = try? JSONSerialization.jsonObject(with: data, options: [])
        if let dictionary = jsonResult as? [String: Any] {
            if let status = dictionary["status"] as? String {
                if status == "OK" {
                    if let str = dictionary["signUpLink"] as? String {
                        resString = str
                    }
                }
            }
        }
        return resString
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
            UserDefaults.standard.set(balance, forKey: "balance")
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
    
//    static func parseFullOrder(data: Data) -> FullOrderData {
//        let fullData = FullOrderData()
//        let jsonResult  = try? JSONSerialization.jsonObject(with: data, options: [])
//        if let dictionary = jsonResult as? [String: Any] {
//            if let balance = dictionary["balance"] as? String {
//                fullData.balance = balance
//            }
//            if let status = dictionary["status"] as? String {
//                fullData.status = status
//            }
//            fullData.fullOrderLayout = parseFullOrderLayout(dictionarie: dictionary)
//        }
//        return fullData
//    }
//
//    static private func parseFullOrderLayout(dictionarie: [String: Any]) -> FullOrderLayout{
//        let fullOrderLayout = FullOrderLayout()
//        if let dictionary = dictionarie["fullOrderLayout"] as? [String: Any] {
//            if let orderNumber = dictionary["orderNumber"] as? String {
//                fullOrderLayout.orderNumber = orderNumber
//            }
//            if let orderId = dictionary["orderId"] as? String {
//                fullOrderLayout.orderId = orderId
//            }
//            if let showDeleteButton = dictionary["showDeleteButton"] as? Bool {
//                fullOrderLayout.showDeleteButton = showDeleteButton
//            }
//            if let deleteButtonText = dictionary["deleteButtonText"] as? String {
//                fullOrderLayout.deleteButtonText = deleteButtonText
//            }
//
//            fullOrderLayout.blocks = parseLayoutBlocks(dictionary: dictionary)
//        }
//        return fullOrderLayout
//    }
//
//    static private func parseLayoutBlocks(dictionary: [String: Any]) -> [Block] {
//        var blocks = [Block]()
//        if let localBlocks = dictionary["blocks"] as? [Any] {
//            for i in 0..<localBlocks.count {
//                if let localBlock = localBlocks[i] as? [String: Any] {
//                    let block = Block()
//                    block.rows = parseLayoutRows(dictionary: localBlock)
//                    blocks.append(block)
//                }
//            }
//        }
//        return blocks
//    }
//
//    static private func parseLayoutRows(dictionary: [String: Any]) -> [Row] {
//        var rows = [Row]()
//        if let localRows = dictionary["rows"] as? [Any] {
//            for i in 0..<localRows.count {
//                if let localRow = localRows[i] as? [String: Any] {
//                    let row = Row()
//                    row.views = parseLayoutViews(dictionary: localRow)
//                    rows.append(row)
//                }
//            }
//        }
//        return rows
//    }
//
//    static private func parseLayoutViews(dictionary: [String: Any]) -> [View] {
//        var views = [View]()
//        if let localViews = dictionary["views"] as? [Any] {
//            for i in 0..<localViews.count{
//                if let localView = localViews[i] as? [String: Any] {
//                    let view = View()
//                    if let type = localView["type"] as? String {
//                        view.type = type
//                    }
//                    if let content = localView["content"] as? String {
//                        view.content = content
//                    }
//                    if let gravity = localView["gravity"] as? String {
//                        view.gravity = gravity
//                    }
//                    if let color = localView["color"] as? String {
//                        view.color = color
//                    }
//                    if let bgColor = localView["bgColor"] as? String {
//                        view.bgColor = bgColor
//                    }
//                    if let weight = localView["weight"] as? Int {
//                        view.weight = weight
//                    }
//                    if let isHTML = localView["isHTML"] as? Bool {
//                        view.isHTML = isHTML
//                    }
//                    view.children = parseChildrens(dictionary: localView)
//                    views.append(view)
//                }
//            }
//        }
//        return views
//    }
//
//    private static func parseChildrens(dictionary: [String: Any]) -> [Children] {
//        var childrens = [Children]()
//
//        if let localChildrens = dictionary["children"] as? [Any] {
//            for i in 0..<localChildrens.count {
//                if let localChildren = localChildrens[i] as? [String: Any] {
//                    let children = Children()
//                    if let type = localChildren["type"] as? String {
//                        children.type = type
//                    }
//                    if let singleLine = localChildren["singleLine"] as? Bool {
//                        children.singleLine = singleLine
//                    }
//                    if let isHTML = localChildren["isHTML"] as? Bool {
//                        children.isHTML = isHTML
//                    }
//                    if let gravity = localChildren["gravity"] as? String {
//                        children.gravity = gravity
//                    }
//                    if let orientation = localChildren["orientation"] as? String {
//                        children.orientation = orientation
//                    }
//                    if let weight = localChildren["weight"] as? Int {
//                        children.weight = weight
//                    }
//                    if let content = localChildren["content"] as? String {
//                        children.content = content
//                    }
//                    childrens.append(children)
//                }
//            }
//        }
//
//        return childrens
//    }
}

protocol LogInDelegate: class {
    func failureAction(errorText: String)
    func successAction()
}
