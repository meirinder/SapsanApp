//
//  HTTPConnector.swift
//  SapsanApp
//
//  Created by Savely on 08.11.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import UIKit

class HTTPConnector: NSObject {

    let APIVERSION = "2.0"
    
    func login(phone: String, password: String, completion: @escaping (LoginJSONStructure) -> ())  {
        
        var loginJSON = LoginJSONStructure()
        
        var formattedPhoneNumber = String()
        formattedPhoneNumber = phone.formatPhoneNumber()
        let body = "phone=" + formattedPhoneNumber + "&" + "password=" + password
        let dataOfBody = body.data(using: String.Encoding.utf8)
        let loginURL = URL(string:"http://app.sapsan.cloud/api/client/"+APIVERSION+"/login.php")!
        var reqest = URLRequest(url: loginURL )
        reqest.httpMethod = "POST"
        reqest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
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
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            
            do{
                loginJSON = try JSONDecoder().decode(LoginJSONStructure.self, from: data)
                print(loginJSON.status!)
                completion(loginJSON)
            }catch let error {
                print(error)
                completion(loginJSON)
            }
            
        }
        task.resume()
    }
    
    
    func getOrders(idCompany : String, idUser : String, key : String,completion: @escaping (OrderStructure) -> ()){
        var OrdersJSON = OrderStructure()
        
        
        let body = "class=app_orders_helper&method=add_short_orders&idCompany=" + idCompany + "&" + "idUser=" + idUser
        let dataOfBody = body.data(using: String.Encoding.utf8)
        let loginURL = URL(string:"http://app.sapsan.cloud/api/client/"+APIVERSION+"/orders.php")!
        var reqest = URLRequest(url: loginURL )
        reqest.httpMethod = "POST"
        reqest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
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
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            
            do{
                OrdersJSON = try JSONDecoder().decode(OrderStructure.self, from: data)
                
                
               // print(OrdersJSON.status!)
                completion(OrdersJSON)
            }catch let error {
                print(error)
            }
        }
        task.resume()
        
     //   return OrdersJSON
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
