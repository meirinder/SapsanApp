//
//  DropDownCreateTableViewCell.swift
//  SapsanApp
//
//  Created by Savely on 13/03/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class DropDownCreateTableViewCell: UITableViewCell {

    var viewModel: CreateOrderCellViewModel?
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var filialsTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    private var row: CreationRow?
    var tableHeight: Int?
    var delegate: UITableView?
    var creationDictionary: ResultOrderCreation!

    
    func setCell() {
        let outRow = viewModel?.dropDownRow()
        row = outRow
        if row?.type == "from_dropdown" {
            let localRow = row as! FromDropDownRow
            tableHeight = (localRow.items?.count ?? 0) * 45
        } else {
            let localRow = row as! WhenDropDownRow
            tableHeight = (localRow.items?.count ?? 0) * 45
        }
        if outRow?.type == "from_dropdown" {
            let localRow = outRow as! FromDropDownRow
            titleButton.setHTMLFromString(text: localRow.label ?? "erroLabel")

        } else {
            let localRow = outRow as! WhenDropDownRow
             titleButton.setHTMLFromString(text: localRow.label ?? "errorLabel")
        }
    }
    
    @IBAction func dropDownAction(_ sender: UIButton) {
        if tableViewHeight.constant == 0 {
            tableViewHeight.constant = CGFloat(tableHeight!)
        } else {
            tableViewHeight.constant = 0
        }
        delegate?.reloadData()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        filialsTableView.dataSource = self
        filialsTableView.delegate = self
        tableViewHeight.constant = 0
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension DropDownCreateTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if row?.type == "from_dropdown" {
            let localRow = row as! FromDropDownRow
            UserDefaults.standard.set(localRow.items?[indexPath.row].id, forKey: "filialId")
            localRow.label = localRow.prefix + (localRow.items?[indexPath.row].name ?? "errorLabel")
            if let name = localRow.name {
                creationDictionary.dict[name] = localRow.items?[indexPath.row].id ?? ""
            }
            tableViewHeight.constant = 0
            delegate?.reloadData()
        } else {
            let localRow = row as! WhenDropDownRow
            localRow.label = localRow.prefix + (localRow.items?[indexPath.row].name ?? "errorLabel")
            if let name = localRow.name {
                creationDictionary.dict[name] = localRow.items?[indexPath.row].name ?? ""
            }
            tableViewHeight.constant = 0
            delegate?.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if row?.type == "from_dropdown" {
            let localRow = row as! FromDropDownRow
            return localRow.items?.count ?? 0
        } else {
            let localRow = row as! WhenDropDownRow
            return localRow.items?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filialNameCell", for: indexPath)
        
        if row?.type == "from_dropdown" {
            let localRow = row as! FromDropDownRow
            cell.textLabel?.text = localRow.items?[indexPath.row].name
        } else {
            let localRow = row as! WhenDropDownRow
            cell.textLabel?.text = localRow.items?[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
