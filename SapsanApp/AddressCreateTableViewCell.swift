//
//  AddressCreateTableViewCell.swift
//  SapsanApp
//
//  Created by Savely on 13/03/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class AddressCreateTableViewCell: UITableViewCell {

    var viewModel: CreateOrderCellViewModel?
    weak var delegate: AddressVCDelegate?

    func setCell() {
        let dict = viewModel?.addressDict()
        questionLabel.attributedText = dict?["label"]??.htmlToAttributedString
        answerTextField.placeholder = dict?["hint"] ?? "errorHint"
    }
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBAction func editingDidBeginAction(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddressViewController") as! AddressViewController
        vc.delegate = delegate
        self.answerTextField.endEditing(true)
        delegate?.pushVC(vc: vc)
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
