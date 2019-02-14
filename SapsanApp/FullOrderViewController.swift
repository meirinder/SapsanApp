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
      
        fullOrderViewModel.getMarkup()
        
        
        // Do any additional setup after loading the view.
    }
    
    func reloadViews() {
        DispatchQueue.main.async {
            self.navigationItem.title = self.fullOrderViewModel.title()
            self.layoutTableView.reloadData()
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
        return 16
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch fullOrderViewModel.cellType(section: indexPath.section, index: indexPath.row) {
        case .double:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoubleLayoutCell", for: indexPath) as! DoubleTableViewCell
            cell.fullOrderCellViewModel = fullOrderViewModel.buildViewModelForCell(section: indexPath.section, index: indexPath.row)
            return cell
        case .multi:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MultiLayoutCell", for: indexPath) as! MultiTableViewCell
            cell.fullOrderCellViewModel = fullOrderViewModel.buildViewModelForCell(section: indexPath.section, index: indexPath.row)
            return cell
        case .quatro:
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuatroLayoutCell", for: indexPath) as! QuatroTableViewCell

            cell.fullOrderCellViewModel = fullOrderViewModel.buildViewModelForCell(section: indexPath.section, index: indexPath.row)
            return cell
        case .none:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoubleLayoutCell", for: indexPath) as! DoubleTableViewCell
            cell.fullOrderCellViewModel = fullOrderViewModel.buildViewModelForCell(section: indexPath.section, index: indexPath.row)
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
