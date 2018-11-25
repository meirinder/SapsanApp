//
//  LoginJSONStructure.swift
//  SapsanApp
//
//  Created by Savely on 08.11.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import Foundation

struct UserCompanies : Decodable {
    var idUser : String?
    var idCompany : String?
    var name : String?
    var companyName: String?
}

struct Support_info: Decodable{
    var name: String?
    var email: String?
    var phone: String?
}


struct LoginJSONStructure : Decodable {
    var dispatcherPhone : String?
    var status : String?
    var key  : String?
    var userCompanies = [UserCompanies]()
    var support_info: Support_info?
}

