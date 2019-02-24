//
//  TransactionDetailViewModel.swift
//  SapsanApp
//
//  Created by Savely on 24/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class TransactionDetailViewModel: NSObject {

    let transaction: ShortTransaction
    
    
    init(transaction: ShortTransaction) {
        self.transaction = transaction
    }
    
    func orderId() -> String {
        return transaction.orderId ?? "errorId"
    }
    
    func date() -> String {
        return transaction.date ?? "errorDate"
    }
    
    func type() -> String {
        return transaction.type  ?? "errorType"
    }
    
    func balanceAfter() -> String {
        return transaction.balanceAfter  ?? "errorBalance"
    }
    
    func sum() -> String {
        return transaction.sum  ?? "errorSum"
    }
    
}
