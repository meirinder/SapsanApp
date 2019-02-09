//
//  SupportViewModel.swift
//  SapsanApp
//
//  Created by Savely on 05/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class SupportViewModel: NSObject {

    private var supportInfo: SupportInfo!
    
    func phone() -> String {
        return (supportInfo?.phone)!
    }
    
    func name() -> String {
        return (supportInfo?.name)!
    }
    
    func email() -> String {
        return (supportInfo?.eMail)!
    }
    
    func getInfo() {
        supportInfo = Menu.menuViewModel.loginData.supportInfo
    }
    
    
}
