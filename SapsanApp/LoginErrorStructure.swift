//
//  LoginErrorStructure.swift
//  SapsanApp
//
//  Created by Savely on 12.11.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import Foundation
struct LoginErrorStructure : Decodable {
    var status : String?
    var errorText  : String?
}
