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
    var delegate: UITableView?
    
    func setCell() {
        let outRow = viewModel?.dropDownRow()
        row = outRow
        if outRow?.type == "from_dropdown" {
            let localRow = outRow as! FromDropDownRow
            titleButton.setAttributedTitle(localRow.label?.htmlToAttributedString, for: .normal)

        } else {
            let localRow = outRow as! WhenDropDownRow
             titleButton.setAttributedTitle(localRow.label?.htmlToAttributedString, for: .normal)
        }
    }
    
    @IBAction func dropDownAction(_ sender: UIButton) {
        if tableViewHeight.constant == 0 {
            tableViewHeight.constant = 160
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
