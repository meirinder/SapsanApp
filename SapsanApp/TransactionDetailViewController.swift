//
//  TransactionDetailViewController.swift
//  SapsanApp
//
//  Created by Savely on 24/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class TransactionDetailViewController: UIViewController {

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    var transactionDetailViewModel: TransactionDetailViewModel? {
        didSet{
            if (dateLabel != nil) && (typeLabel != nil) && (sumLabel != nil) && (balanceLabel != nil) {
                dateLabel.text = transactionDetailViewModel?.date()
                typeLabel.text = transactionDetailViewModel?.type()
                sumLabel.text = transactionDetailViewModel?.sum()
                balanceLabel.text = transactionDetailViewModel?.balanceAfter()
            }
        }
    }
    
    @IBAction func openOrderAction(_ sender: UIButton) {
        let fullorderViewModel = FullOrderViewModel(orderId: transactionDetailViewModel?.orderId() ?? "")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FullOrderViewController") as? FullOrderViewController
        vc?.fullOrderViewModel = fullorderViewModel
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if transactionDetailViewModel != nil {
            dateLabel.text = transactionDetailViewModel?.date()
            typeLabel.text = transactionDetailViewModel?.type()
            sumLabel.text = transactionDetailViewModel?.sum()
            balanceLabel.text = transactionDetailViewModel?.balanceAfter()
        }
        
        // Do any additional setup after loading the view.
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
