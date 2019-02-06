//
//  StartViewModel.swift
//  SapsanApp
//
//  Created by Savely on 05/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class StartViewModel: NSObject {

    weak var delegate: UnlockAppDelegate?
    
    var data = LoginData()

    func setLoginData(data: LoginData) {
        self.data = data
    }

    func loginData() -> LoginData {
        return data
    }
    
    func checkUserDefaults() -> Bool {
         
        return false
    }
    
    func buildOrdersViewModel() -> OrdersViewModel {
        let ordersViewModel = OrdersViewModel()
        return ordersViewModel
    }
    
    func enter(phoneText: String, passText: String) {
         NetWorker.login(phone: phoneText, password: passText) { outData in
            if let logData = JSONWorker.parseLoginData(data: outData) {
                if logData.status == "ERROR"{
                    self.delegate?.failure(text: logData.errorText ?? "errorText")
                    return
                }
                self.data = logData
                UserDefaults.standard.set(logData.userCompanies?.first?.idCompany, forKey: "idCompany")
                UserDefaults.standard.set(logData.userCompanies?.first?.idUser, forKey: "idUser")
                UserDefaults.standard.set(logData.key, forKey: "key")
                self.delegate?.loginApp()
            }
        }
    }
    
}