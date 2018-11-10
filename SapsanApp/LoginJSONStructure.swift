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
}


struct LoginJSONStructure : Decodable {
    var status : String?
    var key  : String?
    var userCompanies = [UserCompanies]()
}

