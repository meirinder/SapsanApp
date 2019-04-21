//
//  JSONWorker.swift
//  CityCourier
//
//  Created by Savely on 03/02/2019.
//  Copyright © 2019 CityCourier. All rights reserved.
//

import UIKit

class JSONWorker: NSObject {
    
    static var navigationController = UINavigationController() {
        didSet{
            print(self.navigationController as Any)
        }
    }
    
    private static func checkError(status: String) {
        if status == "DISACTIVE" {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "StartViewController") as! StartViewController
            AlertBuilder.simpleAlert(title: "Ошибка", message: "Ваш аккаунт заблокирован", controller: (JSONWorker.navigationController.topViewController)!){
                DispatchQueue.main.async {
                    UserDefaults.standard.removeObject(forKey: "key")
                    JSONWorker.navigationController.setViewControllers([vc], animated: true)
                }
            }
        }
        if status == "NO_ACCESS" {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "StartViewController") as! StartViewController
            AlertBuilder.simpleAlert(title: "Ошибка", message: "Сессия истекла", controller: (JSONWorker.navigationController.topViewController)!) {
                    DispatchQueue.main.async {
                        UserDefaults.standard.removeObject(forKey: "key")
                        JSONWorker.navigationController.setViewControllers([vc], animated: true)
                    }
            }
           
            
        }
        if status == "DEPRECATED" {
            AlertBuilder.simpleAlert(title: "Новости", message: "Пожалуйста, обновите приложение", controller: (JSONWorker.navigationController.topViewController)!)
        }
    }
    
    static func parseDeleteInfo(data: Data) -> (show: Bool,text: String) {
        var resultString = ""
        let jsonResult  = try? JSONSerialization.jsonObject(with: data, options: [])
        if let dictionary = jsonResult as? [String: Any] {
            if let deleteInfo = dictionary["deleteInfo"] as? [String: Any] {
                if let status = dictionary["deleteStatus"] as? Int {
                    if status == 0 {
                        return (false,"")
                    }
                }
                if let title = deleteInfo["buttonText"] as? String {
                    resultString = title
                }
            }
        }
        return (true,resultString)
    }
    
    static func parseInstructions(data: Data) -> [HelpTypes] {
        var result = [HelpTypes]()
        let jsonResult  = try? JSONSerialization.jsonObject(with: data, options: [])
        if let dictionary = jsonResult as? [String: Any] {
            if let helpTypes = dictionary["helpTypes"] as? [Any] {
                for i in 0..<helpTypes.count {
                    let localHelp = HelpTypes()
                    if let helpType = helpTypes[i] as? [String: Any] {
                        if let id = helpType["id"] as? Int {
                            localHelp.id = id
                        }
                        if let value = helpType["value"] as? String {
                            localHelp.value = value
                        }
                    }
                    result.append(localHelp)
                }
            }
        }
        return result
    }
    
    static func parseFullOrdersInFile(data: Data) -> FullOrderData{
        let fullOrderData = FullOrderData()
        let jsonResult  = try? JSONSerialization.jsonObject(with: data, options: [])
        if let dictionary = jsonResult as? [String: Any] {
            if let status = dictionary["status"] as? String {
                fullOrderData.status = status
                JSONWorker.checkError(status: fullOrderData.status ?? "")
            }
            if let balance = dictionary["balance"] as? String {
                fullOrderData.balance = balance
                UserDefaults.standard.set(balance, forKey: "balance")
            }
            fullOrderData.fullOrderLayout = parseFullOrderLayput(dictionary: dictionary)
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
                        if let leftkey = localRow["left_key"] as? [String: Any] {
                            row.leftKeyText = parseRowValue(dict: leftkey)
                        }
                        if let rightKey = localRow["right_key"] as? [String: Any] {
                            row.rightKeyText = parseRowValue(dict: rightKey)
                        }
                        if let leftValue = localRow["left_value"] as? [String: Any] {
                            row.leftValueText = parseRowValue(dict: leftValue)
                        }
                        if let rightValue = localRow["right_value"] as? [String: Any] {
                            row.rightValueText = parseRowValue(dict: rightValue)
                        }
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
                    case .courier:
                        let row = CourierRow()
                        if let photoLink = localRow["photoLink"] as? [String: Any] {
                            row.photoLink = parseRowValue(dict: photoLink)
                        }
                        if let nameText = localRow["nameText"] as? [String: Any] {
                            row.nameText = parseRowValue(dict: nameText)
                        }
                        if let phoneText = localRow["phoneText"] as? [String: Any] {
                            row.phoneText = parseRowValue(dict: phoneText)
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
        if let bgColor = dict["bgColor"] as? String {
            rowValue.bgColor = bgColor
        }
        if let color = dict["color"] as? String {
            rowValue.color = color
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
            case "courier":
                return .courier
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
                JSONWorker.checkError(status: transactionsData.status ?? "")
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
                JSONWorker.checkError(status: ordersData.status ?? "")
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
                     if let deliveryMoney = order["deliveryMoney"] {
                        localOrder.deliveryMoney = "\(deliveryMoney)"
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
                JSONWorker.checkError(status: loginData.status ?? "")
                loginData.errorText = checkErrorInLogin(dictionary: dictionary).text
                return loginData
            }
            let outData = setLoginProperties(dictionarie: dictionary)
            if let status = dictionary["status"] as? String {
                outData.status = status
            }
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
                JSONWorker.checkError(status: status )
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
            JSONWorker.checkError(status: loginData.status ?? "")
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
    
    private static func parseDropDownItems(dict: [String: Any]) -> [DropDownItem] {
        var dropDownItems = [DropDownItem]()
        if let localItems = dict["items"] as? [Any] {
            for i in 0..<localItems.count {
                if let localItem = localItems[i] as? [String: Any] {
                    let item = DropDownItem()
                    if let id = localItem["id"] as? String {
                        item.id = id
                    }
                    if let name = localItem["name"] as? String {
                        item.name = name
                    }
                    dropDownItems.append(item)
                }
            }
        }
        return dropDownItems
    }
    
    private static func parseCreationRowValue(dict: [String: Any]) -> CreationRowValue {
        let value = CreationRowValue()
        if let hint = dict["hint"] as? String {
            value.hint = hint
        }
        if let keyboard_type = dict["keyboard_type"] as? String {
            value.keyboard_type = keyboard_type
        }
        if let type = dict["type"] as? String {
            value.type = type
        }
        if let label = dict["label"] as? String {
            value.label = label
        }
        if let name = dict["name"] as? String {
            value.name = name
        }
        return value
        
    }
    
    private static func parseCreationRows(dict: [String: Any]) -> [CreationRow] {
        var rows = [CreationRow]()
        if let localRows = dict["rows"] as? [Any] {
            for j in 0..<localRows.count {
                if let localRow = localRows[j] as? [String: Any] {
                    if let type = localRow["type"] as? String {
                        switch type {
                        case "when_dropdown":
                            let row = WhenDropDownRow()
                            row.type = type
                            if let label = localRow["label"] as? String {
                                row.label = label
                            }
                            if let name = localRow["name"] as? String {
                                row.name = name
                            }
                            row.items = parseDropDownItems(dict: localRow)
                            rows.append(row)
                            break
                        case "from_dropdown":
                            let row = FromDropDownRow()
                            row.type = type
                            if let label = localRow["label"] as? String {
                                row.label = label
                            }
                            if let name = localRow["name"] as? String {
                                row.name = name
                            }
                            row.items = parseDropDownItems(dict: localRow)
                            rows.append(row)
                            break
                        case "2x2_grid":
                            let row = DoubleDoubleGridRow()
                            row.type = type
                            if let topLeftText = localRow["left_top"] as? [String: Any] {
                                row.topLeftText = parseCreationRowValue(dict: topLeftText)
                            }
                            if let topRightText = localRow["right_top"] as? [String: Any] {
                                row.topRightText = parseCreationRowValue(dict: topRightText)
                            }
                            if let botLeftText = localRow["left_bottom"] as? [String: Any] {
                                row.botLeftText = parseCreationRowValue(dict: botLeftText)
                            }
                            if let botRightText = localRow["right_bottom"] as? [String: Any] {
                                row.botRightText = parseCreationRowValue(dict: botRightText)
                            }
                            rows.append(row)
                            break
                        case "2x1_grid":
                            let row = DoubleSoloGridRow()
                            row.type = type
                            if let leftText = localRow["left"] as? [String: Any] {
                                row.leftText = parseCreationRowValue(dict: leftText)
                            }
                            if let rightText = localRow["right"] as? [String: Any] {
                                row.rightText = parseCreationRowValue(dict: rightText)
                            }
                            
                            rows.append(row)
                            break
                        case "solo_grid":
                            let row = SoloGridRow()
                            row.type = type
                            if let value = localRow["value"] as? [String: Any] {
                                row.value = parseCreationRowValue(dict: value)
                            }
                            
                            rows.append(row)
                            break
                        case "2_checkboxes":
                            let row = DoubleCheckBoxesRow()
                            row.type = type
                            if let left = localRow["left"] as? [String: Any] {
                                row.left = parseCreationRowValue(dict: left)
                            }
                            if let right = localRow["right"] as? [String: Any] {
                                row.right = parseCreationRowValue(dict: right)
                            }
                            
                            rows.append(row)
                            break
                        case "address_edit_text":
                            let row = AdressEditRow()
                            row.type = type
                            if let label = localRow["label"] as? String {
                                row.label = label
                            }
                            if let name = localRow["name"] as? String {
                                row.name = name
                            }
                            if let hint = localRow["hint"] as? String {
                                row.hint = hint
                            }
                            
                            rows.append(row)
                            break
                        default:
                            let row = CreationRow()
                            row.type = type

                            rows.append(row)
                            break
                        }
                    }
                }
            }
        }
        return rows
    }
    
    private static func parseCreationBlocks(dict: [String: Any]) -> [CreationBlock] {
        var blocks = [CreationBlock]()
        if let localBlocks = dict["blocks"] as? [Any] {
            for i in 0..<localBlocks.count {
                if let localBlock = localBlocks[i] as? [String: Any] {
                    let block = CreationBlock()
                    block.rows = parseCreationRows(dict: localBlock)
                    blocks.append(block)
                }
            }
        }
        return blocks
    }
  
    
    static func parseAdresses(data: Data) -> [Address] {
        var addresses = [Address]()
        let jsonResult  = try? JSONSerialization.jsonObject(with: data, options: [])
        if let dictionary = jsonResult as? [String: Any] {
            if let searchAddresses = dictionary["searchAddresses"] as? [Any] {
                for i in 0..<searchAddresses.count {
                    if let searchAddress = searchAddresses[i] as? [String: Any] {
                        let address = Address()
                        if let coordi = searchAddress["coord"] as? [String: Any] {
                            let coordinat = Coord()
                            if let lat = coordi["lat"] as? String {
                                coordinat.lat = lat
                            }
                            if let lng = coordi["lng"] as? String {
                                coordinat.lng = lng
                            }
                            if let coord = coordi["coord"] as? String {
                                coordinat.coord = coord
                            }
                            address.coord = coordinat
                        }
                        if let city = searchAddress["city"] as? String  {
                            address.city = city
                        }
                        if let text = searchAddress["text"] as? String  {
                            address.text = text
                        }
                        if let region = searchAddress["region"] as? String  {
                            address.region = region
                        }
                        addresses.append(address)
                    }
                }
            }
            
        }
        return addresses
    }
    
    static func parseCreationLayout(data: Data) -> CreationOrderData {
        let creationOrderData = CreationOrderData()
        let jsonResult  = try? JSONSerialization.jsonObject(with: data, options: [])
        if let dictionary = jsonResult as? [String: Any] {
            if let status = dictionary["status"] as? String {
                creationOrderData.status = status
                JSONWorker.checkError(status: creationOrderData.status ?? "")
            }
            if let balance = dictionary["balance"] as? String {
                creationOrderData.balance = balance
                UserDefaults.standard.set(balance, forKey: "balance")
            }
            if let creationLayout = dictionary["creationLayout"] as? [String: Any] {
                creationOrderData.creationLayout = CreationLayout()
                creationOrderData.creationLayout!.blocks = parseCreationBlocks(dict: creationLayout)
            }
        }
        return creationOrderData
    }
    
}

protocol LogInDelegate: class {
    func failureAction(errorText: String)
    func successAction()
}
