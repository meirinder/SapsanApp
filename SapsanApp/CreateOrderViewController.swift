//
//  CreateOrderViewController.swift
//  SapsanApp
//
//  Created by Savely on 25/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class CreateOrderViewController: UIViewController {
    @IBOutlet weak var CreateBarButtonItem: UIBarButtonItem!
    
    var viewModel: CreateOrderViewModel?{
        didSet {
            viewModel?.delegate = self
            viewModel!.getLayout()
        }
    }
    @IBOutlet weak var createOrderTableView: UITableView!
    
    var creationDictionary = ResultOrderCreation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createOrderTableView.delegate = self
        createOrderTableView.dataSource = self
//        self.addTapGestureToHideKeyboard()
        JSONWorker.navigationController = self.navigationController!

        NotificationCenter.default.addObserver(self, selector: #selector(CreateOrderViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateOrderViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    @IBAction func createAction(_ sender: Any) {
        print(creationDictionary.dict)
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
            cell.creationDictionary = creationDictionary
            return cell
        case "2x2_grid":
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuatroCreateTableViewCell", for: indexPath) as! QuatroCreateTableViewCell
            cell.viewModel = viewModel?.viewModel(section: indexPath.section, index: indexPath.row)
            cell.setCell()
            cell.creationDictionary = creationDictionary
            return cell
        case "from_dropdown":
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCreateTableViewCell", for: indexPath) as! DropDownCreateTableViewCell
            cell.viewModel = viewModel?.viewModel(section: indexPath.section, index: indexPath.row)
            cell.delegate = tableView
            cell.setCell()
            cell.creationDictionary = creationDictionary
            return cell
        case "when_dropdown":
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCreateTableViewCell", for: indexPath) as! DropDownCreateTableViewCell
            cell.viewModel = viewModel?.viewModel(section: indexPath.section, index: indexPath.row)
            cell.delegate = tableView
            cell.setCell()
            cell.creationDictionary = creationDictionary
            return cell
        case "solo_grid":
            let cell = tableView.dequeueReusableCell(withIdentifier: "SoloCreateTableViewCell", for: indexPath) as! SoloCreateTableViewCell
            cell.viewModel = viewModel?.viewModel(section: indexPath.section, index: indexPath.row)
            cell.setCell()
            cell.creationDictionary = creationDictionary
            return cell
        case "address_edit_text":
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCreateTableViewCell", for: indexPath) as! AddressCreateTableViewCell
            cell.delegate = self
            cell.viewModel = viewModel?.viewModel(section: indexPath.section, index: indexPath.row)
            cell.setCell()
            cell.creationDictionary = creationDictionary
            return cell
        case "2_checkboxes":
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckBoxesCreateTableViewCell", for: indexPath) as! CheckBoxesCreateTableViewCell
            cell.viewModel = viewModel?.viewModel(section: indexPath.section, index: indexPath.row)
            cell.setCell()
            cell.creationDictionary = creationDictionary
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
//            if self.view.frame.origin.y >= 0{
//                print(self.view.frame.origin.y)
//                print("Show")
//                self.view.frame.origin.y -= keyboardSize.height
//            }
        }
    }
    
    @objc override func keyboardWillHide(notification:NSNotification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y < 0{
//                print(self.view.frame.origin.y)
//                print("Hide")
//                self.view.frame.origin.y = 0
//            }
        }
    }
}

extension CreateOrderViewController: ReloadTableViewDelegate, AddressVCDelegate {
    func popToThisVC() {
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    func pushVC(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.createOrderTableView.reloadData()
        }
    }
}

 
protocol AddressVCDelegate: class {
    func popToThisVC()
    func pushVC(vc: UIViewController)
}
