//
//  NetWorker.swift
//  CityCourier
//
//  Created by Savely on 03/02/2019.
//  Copyright © 2019 CityCourier. All rights reserved.
//

import UIKit

class NetWorker {
    
    private static let APIVERSION = "2.0"
    
    
    static func instructionLink(completion: @escaping (String) -> ()) {
        let idCompany = UserDefaults.standard.object(forKey: "idCompany") as? String ?? ""
        let idUser = UserDefaults.standard.object(forKey: "idUser") as? String ?? ""
        let key = UserDefaults.standard.object(forKey: "key") as? String ?? ""
        
       let body = "class=company_user&method=add_instructions_link&idCompany=" + idCompany + "&" + "idUser=" + idUser
        let dataOfBody = body.data(using: String.Encoding.utf8)
        let loginURL = URL(string:"http://app.citycourier.pro/api/client/"+APIVERSION+"/user.php")!
        var reqest = URLRequest(url: loginURL )
        reqest.httpMethod = "POST"
        reqest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        reqest.setValue("iOS", forHTTPHeaderField: "App-OS")
        reqest.setValue(key, forHTTPHeaderField: "Mobile-Key")
        reqest.httpBody = dataOfBody
        
        let task = URLSession.shared.dataTask(with: reqest){data,response,error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            if let responseString = String(data: data, encoding: .utf8) {
                completion(responseString)
            }

            //                        print("responseString = \(String(describing: responseString))")
            
        }
        task.resume()
    }
    
    static func login(phone: String, password: String, completion: @escaping (Data) -> ())  {
        var formattedPhoneNumber = String()
        formattedPhoneNumber = phone.formatPhoneNumber()
        let body = "phone=" + formattedPhoneNumber + "&" + "password=" + password
        let dataOfBody = body.data(using: String.Encoding.utf8)
        let loginURL = URL(string:"http://app.citycourier.pro/api/client/"+APIVERSION+"/login.php")!
        var reqest = URLRequest(url: loginURL )
        reqest.httpMethod = "POST"
        reqest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        reqest.setValue("iOS", forHTTPHeaderField: "App-OS")
        reqest.httpBody = dataOfBody
        
        
        let task = URLSession.shared.dataTask(with: reqest){data,response,error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            completion(data)
//                        let responseString = String(data: data, encoding: .utf8)
//                        print("responseString = \(String(describing: responseString))")
            
        }
        task.resume()
    }
    
    static func changeUser(newIdCompany: String, newIdUser: String, completion: @escaping (Data) -> ()) {
        let idCompany = UserDefaults.standard.object(forKey: "idCompany") as? String ?? ""
        let idUser = UserDefaults.standard.object(forKey: "idUser") as? String ?? ""
        let key = UserDefaults.standard.object(forKey: "key") as? String ?? ""
 
        let body = "class=access&method=change_user&idCompany=" + idCompany + "&" + "idUser=" + idUser + "&newIdCompany=" + newIdCompany + "&" + "newIdUser=" + newIdUser
        let dataOfBody = body.data(using: String.Encoding.utf8)
        let loginURL = URL(string:"http://app.citycourier.pro/api/client/"+APIVERSION+"/login.php")!
        var reqest = URLRequest(url: loginURL )
        reqest.httpMethod = "POST"
        reqest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        reqest.setValue("iOS", forHTTPHeaderField: "App-OS")
        reqest.setValue(key, forHTTPHeaderField: "Mobile-Key")
        reqest.httpBody = dataOfBody
        
        
        let task = URLSession.shared.dataTask(with: reqest){data,response,error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            completion(data)
//                        let responseString = String(data: data, encoding: .utf8)
//                        print("responseString = \(String(describing: responseString))")
            
        }
        task.resume()
    }
    
    static func getOrders(idCompany : String, idUser : String, key : String,  first: Int, count: Int, completion: @escaping (Data) -> ()){
        
        let body = "class=orders_helper&method=add_short_orders&idCompany=" + idCompany + "&" + "idUser=" + idUser + "&offset=" + "\(first)" + "&count=" + "\(count)"
        let dataOfBody = body.data(using: String.Encoding.utf8)
        let loginURL = URL(string:"http://app.citycourier.pro/api/client/"+APIVERSION+"/orders.php")!
        var reqest = URLRequest(url: loginURL )
        reqest.httpMethod = "POST"
        reqest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        reqest.setValue(key, forHTTPHeaderField: "Mobile-Key")
        reqest.setValue("iOS", forHTTPHeaderField: "App-OS")
        reqest.httpBody = dataOfBody
        
        
        let task = URLSession.shared.dataTask(with: reqest){data,response,error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            completion(data)
//                        let responseString = String(data: data, encoding: .utf8)
//                        print("responseString = \(String(describing: responseString))")
            
        }
        task.resume()
        
        //   return OrdersJSON
    }
    
    static func getTransactions(idCompany : String, idUser : String, key : String, first: Int, count: Int, completion: @escaping (Data) -> ()){
        
        let body = "class=company_user&method=add_short_transactions&idCompany=" + idCompany + "&" + "idUser=" + idUser + "&offset=" + "\(first)" + "&count=" + "\(count)"
        let dataOfBody = body.data(using: String.Encoding.utf8)
        let loginURL = URL(string:"http://app.citycourier.pro/api/client/"+APIVERSION+"/user.php")!
        var reqest = URLRequest(url: loginURL )
        reqest.httpMethod = "POST"
        reqest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        reqest.setValue(key, forHTTPHeaderField: "Mobile-Key")
        reqest.setValue("iOS", forHTTPHeaderField: "App-OS")
        reqest.httpBody = dataOfBody
        
        
        let task = URLSession.shared.dataTask(with: reqest){data,response,error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            completion(data)
            //                        let responseString = String(data: data, encoding: .utf8)
            //                        print("responseString = \(String(describing: responseString))")
            
        }
        task.resume()
        
        //   return OrdersJSON
    }
    
    
    static func getFullOrders(idCompany : String, idUser : String, idOrder: String, key : String, completion: @escaping (Data) -> ()){
        
        let body = "method=add_full_order_info&class=orders_helper&idCompany=" + idCompany + "&" + "idUser=" + idUser + "&idOrder=" + idOrder
        let dataOfBody = body.data(using: String.Encoding.utf8)
        let loginURL = URL(string:"http://app.citycourier.pro/api/client/"+APIVERSION+"/orders.php")!
        var reqest = URLRequest(url: loginURL )
        reqest.httpMethod = "POST"
        reqest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        reqest.setValue(key, forHTTPHeaderField: "Mobile-Key")
        reqest.setValue("iOS", forHTTPHeaderField: "App-OS")
        reqest.httpBody = dataOfBody
        
        
        let task = URLSession.shared.dataTask(with: reqest){data,response,error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            completion(data)
                                    let responseString = String(data: data, encoding: .utf8)
                                    print("responseString = \(String(describing: responseString))")
            
        }
        task.resume()
        
        //   return OrdersJSON
    }
    
    
    static func recoveryPass(phone: String, completion: @escaping (Data) -> ()) {
        let body = "class=access&method=restore_password&phone=" + phone.formatPhoneNumber()
        let dataOfBody = body.data(using: String.Encoding.utf8)
        let loginURL = URL(string:"http://app.citycourier.pro/api/client/"+APIVERSION+"/login.php")!
        var reqest = URLRequest(url: loginURL )
        reqest.httpMethod = "POST"
        reqest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        reqest.setValue("iOS", forHTTPHeaderField: "App-OS")
        reqest.httpBody = dataOfBody
        
        
        let task = URLSession.shared.dataTask(with: reqest){data,response,error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            completion(data)
                                    let responseString = String(data: data, encoding: .utf8)
                                    print("responseString = \(String(describing: responseString))")
            
        }
        task.resume()
    }
    

    static func signUp(completion: @escaping (Data) -> ()) {
        
        let body = "class=access&method=get_sign_up_link"
        let dataOfBody = body.data(using: String.Encoding.utf8)
        let loginURL = URL(string:"http://app.citycourier.pro/api/client/"+APIVERSION+"/login.php")!
        var reqest = URLRequest(url: loginURL )
        reqest.httpMethod = "POST"
        reqest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        reqest.setValue("iOS", forHTTPHeaderField: "App-OS")
        reqest.httpBody = dataOfBody
        
        
        let task = URLSession.shared.dataTask(with: reqest){data,response,error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            completion(data)
            //                        let responseString = String(data: data, encoding: .utf8)
            //                        print("responseString = \(String(describing: responseString))")
            
        }
        task.resume()
    }
    
}


extension String {
    func formatPhoneNumber() -> String {
        var formattedPhoneNumber = self.replacingOccurrences(of: " ", with: "")
        formattedPhoneNumber = formattedPhoneNumber.replacingOccurrences(of: ")", with: "")
        formattedPhoneNumber = formattedPhoneNumber.replacingOccurrences(of: "(", with: "")
        formattedPhoneNumber = formattedPhoneNumber.replacingOccurrences(of: "-", with: "")
        formattedPhoneNumber = formattedPhoneNumber.replacingOccurrences(of: "+", with: "")
        formattedPhoneNumber = String(formattedPhoneNumber.dropFirst(1))
        return formattedPhoneNumber
    }
}
