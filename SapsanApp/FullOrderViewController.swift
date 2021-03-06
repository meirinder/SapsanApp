//
//  FullOrderViewController.swift
//  SapsanApp
//
//  Created by Savely on 10/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class FullOrderViewController: UIViewController, FullOrderDelegate {

    
    @IBOutlet weak var layoutTableView: UITableView!
    var fullOrderViewModel: FullOrderViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullOrderViewModel.delegate = self
        layoutTableView.delegate = self
        layoutTableView.dataSource = self
//        self.navigationController?.navigationBar.barTintColor =  UIColor(hexString: "#1D2880")
//        self.navigationController?.navigationBar.tintColor = .white
//        self.navigationItem.titleView?.tintColor = .white
        
        JSONWorker.navigationController = self.navigationController ?? UINavigationController()
        
        fullOrderViewModel.getMarkup()
 
        
        // Do any additional setup after loading the view.
    }
    
 
    
    @objc
    func deleteAction() {
//        let message = fullOrderViewModel.deleteText()
        JSONWorker.navigationController = self.navigationController!
        fullOrderViewModel.checkDelete(completion: { (message) in
            AlertBuilder.deleteAlert(title: "Подтверждение", message: message, controller: self, completion:  { text in
                self.fullOrderViewModel.deleteOrder()
            })
        }, failure: {
            self.navigationItem.rightBarButtonItem = nil
        })
        
//        AlertBuilder.simpleAlert(title: , message: message, controller: self)
        }
    
    func reloadViews() {
        DispatchQueue.main.async {
            self.navigationItem.title = self.fullOrderViewModel.title()
            let backButton = UIBarButtonItem()
            backButton.title = "Назад"
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
            self.layoutTableView.reloadData()
            if self.fullOrderViewModel.isDeleteble() {
                let item = UIBarButtonItem(image: UIImage(named: "trash"), style: .plain, target: self, action:  #selector(self.deleteAction))
                self.navigationItem.rightBarButtonItem = item
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FullOrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fullOrderViewModel.blocksCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fullOrderViewModel.rowsCount(block: section)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let borderWidth = CGFloat(0)
        switch fullOrderViewModel.cellType(section: indexPath.section, index: indexPath.row) {
        case .double:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoubleLayoutCell", for: indexPath) as! DoubleTableViewCell
            cell.fullOrderCellViewModel = fullOrderViewModel.buildViewModelForCell(section: indexPath.section, index: indexPath.row)
            cell.setCell()
            cell.layer.borderColor = UIColor(hexString: "#1F007F").cgColor
            cell.layer.borderWidth = borderWidth
            cell.layer.cornerRadius = 12
            return cell
        case .multi:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MultiLayoutCell", for: indexPath) as! MultiTableViewCell
            cell.fullOrderCellViewModel = fullOrderViewModel.buildViewModelForCell(section: indexPath.section, index: indexPath.row)
            cell.setCell()
            cell.layer.borderColor = UIColor(hexString: "#1F007F").cgColor
            cell.layer.borderWidth = borderWidth
            cell.layer.cornerRadius = 12
            return cell
        case .quatro:
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuatroLayoutCell", for: indexPath) as! QuatroTableViewCell
             cell.fullOrderCellViewModel = fullOrderViewModel.buildViewModelForCell(section: indexPath.section, index: indexPath.row)
            cell.setCell()
            cell.layer.borderColor = UIColor(hexString: "#1F007F").cgColor
            cell.layer.borderWidth = borderWidth
            cell.layer.cornerRadius = 12
            return cell
        case .none:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoubleLayoutCell", for: indexPath) as! DoubleTableViewCell
            cell.fullOrderCellViewModel = fullOrderViewModel.buildViewModelForCell(section: indexPath.section, index: indexPath.row)
            cell.setCell()
            cell.layer.borderColor = UIColor(hexString: "#1F007F").cgColor
            cell.layer.borderWidth = borderWidth
            cell.layer.cornerRadius = 12
            return cell
        case .courier:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoLayoutCell", for: indexPath) as! CourierTableViewCell
            cell.fullOrderCellViewModel = fullOrderViewModel.buildViewModelForCell(section: indexPath.section, index: indexPath.row)
            cell.setCell()
            cell.layer.borderColor = UIColor(hexString: "#1F007F").cgColor
            cell.layer.borderWidth = borderWidth
            cell.layer.cornerRadius = 12
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
  
    
}

protocol FullOrderDelegate: class {
    func reloadViews()
}
