//
//  LoginData.swift
//  CityCourier
//
//  Created by Savely on 03/02/2019.
//  Copyright © 2019 CityCourier. All rights reserved.
//

class LoginData {
    var status: String?
    var balance: String?
    var errorText: String?
    var key: String?
    var supportInfo: SupportInfo?
    var dispatcherPhone: String?
    var userCompanies: [UserCompanie]?
}

class UserCompanie {
    var idUser: String?
    var idCompany: String?
    var name: String?
    var companyName: String?
    var idUserCity: String?
}

class SupportInfo {
    var name: String?
    var eMail: String?
    var phone: String?
}
