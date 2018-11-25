//
//  LoginJSONStructure.swift
//  SapsanApp
//
//  Created by Savely on 08.11.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import Foundation

struct UserCompanies : Codable {
    var idUser : String?
    var idCompany : String?
    var name : String?
    var companyName: String?
}

struct Support_info: Codable{
    var name: String?
    var email: String?
    var phone: String?
}


struct LoginJSONStructure :  Codable {
    var dispatcherPhone : String?
    var status : String?
    var key  : String?
    var userCompanies = [UserCompanies]()
    var support_info: Support_info?
}

