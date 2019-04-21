//
//  AddressViewController.swift
//  SapsanApp
//
//  Created by Savely on 21/03/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController, UITextFieldDelegate {

    
    weak var delegate: AddressVCDelegate?
    weak var updateTextDelegate: UpdateTextDelegate?
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    var addresses = [Address]()
    
    
    var timer: Timer?
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        timer?.invalidate()  // Cancel any previous timer
        
        // If the textField contains at least 3 characters…
        let currentText = textField.text ?? ""
        if currentText.count >= 2 {
            
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(runCode), userInfo: nil, repeats: false)
        }
        
        return true
    }
    
    @objc
    func runCode()  {
        NetWorker.getAddresses(address: searchTextField.text!) { (data) in
            self.addresses = JSONWorker.parseAdresses(data: data)
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        searchTableView.delegate = self
        searchTableView.dataSource = self
//        self.navigationItem.backBarButtonItem!.title = "Назад"
        // Do any additional setup after loading the view.
    }
    @IBAction func editingChangeAction(_ sender: UITextField) {
        
    } 
}

extension AddressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath)
        cell.textLabel?.text = addresses[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateTextDelegate?.update(text: addresses[indexPath.row].text ?? "error", coord: addresses[indexPath.row].coord ?? Coord() )
        delegate?.popToThisVC()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
