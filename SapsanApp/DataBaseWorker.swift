//
//  DataBaseWorker.swift
//  SapsanApp
//
//  Created by Savely on 11/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit
import RealmSwift

class DataBaseWorker: NSObject {

    private static var realm = try? Realm()
    
    static func deleteAll() {
        DispatchQueue.main.async {
            try? realm?.write {
                realm?.deleteAll()
            }
        }
    }
    
    static func saveLoginData(loginData: LoginData) {
        DispatchQueue.main.async {
            let outData = convertLoginDataToDataBaseModel(loginData: loginData)
            try? realm?.write {
                realm?.deleteAll()
                realm?.add(outData)
            }
        }
    }
    
    static func loadLoginData() -> LoginData {
        realm = try? Realm()
        var outData = LoginData()
        if let inData = realm?.objects(LoginDataBaseModel.self).first {
            outData = reConvertLoginData(loginData: inData)
        }
        return outData
    }

    private static func reConvertLoginData(loginData: LoginDataBaseModel) -> LoginData {
        let outData = LoginData()
        outData.status = loginData.status
        outData.balance = loginData.balance
        outData.dispatcherPhone = loginData.dispatcherPhone
        outData.key = loginData.key
        if let supInfo = loginData.supportInfo {
            outData.supportInfo = reConvertSupportInfo(supInfo: supInfo)
        }
        outData.userCompanies = reConvertUserCompanies(userCompanies: loginData.userCompanies)
        
        return outData
    }
    
    private static func reConvertUserCompanies(userCompanies: List<UserCompanieDataBaseModel>) -> [UserCompanie] {
        var resultData = [UserCompanie]()
        for company in userCompanies {
            let localData = UserCompanie()
            localData.companyName = company.companyName
            localData.idCompany = company.idCompany
            localData.idUser = company.idUser
            localData.idUserCity = company.idUserCity
            localData.name = company.name
            resultData.append(localData)
        }
        return resultData
    }
    
    private static func reConvertSupportInfo(supInfo: SupportInfoDataBaseModel) -> SupportInfo {
        let resultData = SupportInfo()
        resultData.eMail = supInfo.eMail
        resultData.name = supInfo.name
        resultData.phone = supInfo.phone
        return resultData
    }
    
    private static func convertLoginDataToDataBaseModel(loginData: LoginData) -> LoginDataBaseModel {
        let outData = LoginDataBaseModel()
        outData.status = loginData.status
        outData.balance = loginData.balance
        outData.dispatcherPhone = loginData.dispatcherPhone
        outData.key = loginData.key
        if let supInfo = loginData.supportInfo {
            outData.supportInfo = convertSupportInfo(supInfo: supInfo)
        }
        if let companies = loginData.userCompanies {
            outData.userCompanies = convertUserCompanies(userCompanies: companies)
        }
        return outData
    }
    
    private static func convertUserCompanies(userCompanies: [UserCompanie]) -> List<UserCompanieDataBaseModel> {
        let resultData = List<UserCompanieDataBaseModel>()
        for company in userCompanies {
            let localData = UserCompanieDataBaseModel()
            localData.companyName = company.companyName
            localData.idCompany = company.idCompany
            localData.idUser = company.idUser
            localData.idUserCity = company.idUserCity
            localData.name = company.name
            resultData.append(localData)
        }
        return resultData
    }
    
    private static func convertSupportInfo(supInfo: SupportInfo) -> SupportInfoDataBaseModel {
        let resultData = SupportInfoDataBaseModel()
        resultData.eMail = supInfo.eMail
        resultData.name = supInfo.name
        resultData.phone = supInfo.phone
        return resultData
    }
    
}



class LoginDataBaseModel: Object {
    @objc dynamic var status: String?
    @objc dynamic var balance: String?
    @objc dynamic var errorText: String?
    @objc dynamic var key: String?
    @objc dynamic var supportInfo: SupportInfoDataBaseModel?
    @objc dynamic var dispatcherPhone: String?
    var userCompanies = List<UserCompanieDataBaseModel>()
}



class UserCompanieDataBaseModel: Object {
    @objc dynamic var idUser: String?
    @objc dynamic var idCompany: String?
    @objc dynamic var name: String?
    @objc dynamic var companyName: String?
    @objc dynamic var idUserCity: String?
}

class SupportInfoDataBaseModel: Object {
    @objc dynamic var name: String?
    @objc dynamic var eMail: String?
    @objc dynamic var phone: String?
}
