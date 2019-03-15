//
//  CreateOrderViewController.swift
//  SapsanApp
//
//  Created by Savely on 25/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class CreateOrderViewController: UIViewController {

    var viewModel: CreateOrderViewModel?{
        didSet {
            viewModel!.getLayout()
        }
    }
    @IBOutlet weak var createOrderTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createOrderTableView.delegate = self
        createOrderTableView.dataSource = self
        self.addTapGestureToHideKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(CreateOrderViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateOrderViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    

    

}

extension CreateOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.sectionCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellCount(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel?.cellType(section: indexPath.section, index: indexPath.row) {
        case "2x1_grid":
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoubleCreateTableViewCell", for: indexPath) as! DoubleCreateTableViewCell
            cell.viewModel = viewModel?.viewModel(section: indexPath.section, index: indexPath.row)
            cell.setCell()
            return cell
        case "2x2_grid":
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuatroCreateTableViewCell", for: indexPath) as! QuatroCreateTableViewCell
            cell.viewModel = viewModel?.viewModel(section: indexPath.section, index: indexPath.row)
            cell.setCell()
            return cell
        case "from_dropdown":
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCreateTableViewCell", for: indexPath) as! DropDownCreateTableViewCell
            cell.viewModel = viewModel?.viewModel(section: indexPath.section, index: indexPath.row)
            cell.setCell()
            return cell
        case "when_dropdown":
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCreateTableViewCell", for: indexPath) as! DropDownCreateTableViewCell
            cell.viewModel = viewModel?.viewModel(section: indexPath.section, index: indexPath.row)
            cell.setCell()
            return cell
        case "solo_grid":
            let cell = tableView.dequeueReusableCell(withIdentifier: "SoloCreateTableViewCell", for: indexPath) as! SoloCreateTableViewCell
            cell.viewModel = viewModel?.viewModel(section: indexPath.section, index: indexPath.row)
            cell.setCell()
            return cell
        case "address_edit_text":
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCreateTableViewCell", for: indexPath) as! AddressCreateTableViewCell
            cell.viewModel = viewModel?.viewModel(section: indexPath.section, index: indexPath.row)
            cell.setCell()
            return cell
        case "2_checkboxes":
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckBoxesCreateTableViewCell", for: indexPath) as! CheckBoxesCreateTableViewCell
            cell.viewModel = viewModel?.viewModel(section: indexPath.section, index: indexPath.row)
            cell.setCell()
            return cell
        default:
            let cell = UITableViewCell()
            
            return cell
        }
    }
    
    
}

extension CreateOrderViewController {
    @objc override func keyboardWillShow(notification:NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y >= 0{
                print(self.view.frame.origin.y)
                print("Show")
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc override func keyboardWillHide(notification:NSNotification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y < 0{
                print(self.view.frame.origin.y)
                print("Hide")
                self.view.frame.origin.y = 0
            }
        }
    }
}
