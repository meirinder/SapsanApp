//
//  MenuCoordinator.swift
//  SapsanApp
//
//  Created by Savely on 09/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class MenuCoordinator: EventHadlerDelegate {
   
    private var storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    private var navController: UINavigationController
    private var data: LoginData
    
    init(navController: UINavigationController, data: LoginData) {
        self.navController = navController
        self.data = data
    }
    
    func start() {
        pushOrdersVC()
    }
    
    private func pushOrdersVC() {
        let desVC = storyboard.instantiateViewController(withIdentifier: "OrdersViewController") as! OrdersViewController
        desVC.ordersViewModel = buildOrdersViewModel()
        desVC.ordersViewModel?.delegate = desVC
        Menu.menuViewModel =  buildMenuViewModel()
        Menu.delegate = self
        self.navController.pushViewController(desVC, animated: true)
    }
    
    private func pushTransactionsVC() {
        let transactVC = storyboard.instantiateViewController(withIdentifier: "TransactionViewController") as! TransactionViewController
        transactVC.transactionViewModel = TransactionViewModel()
        transactVC.transactionViewModel.delegate = transactVC
        Menu.delegate = self
        self.navController.pushViewController(transactVC, animated: true)
    }
    
    private func pushSupportVC() {
        let supportVC = storyboard.instantiateViewController(withIdentifier: "SupportViewController") as! SupportViewController
        supportVC.supportViewModel = SupportViewModel()
        self.navController.pushViewController(supportVC, animated: true)
    }
    
    func handleEvent(event: MenuEvents) {
        switch event {
        case .changeUser:
            if let orderVC = self.navController.topViewController as? OrdersViewController {
                orderVC.ordersViewModel?.getOrders(first: 0, count: 20)
            }
            
            if let transactionVC = self.navController.topViewController as? TransactionViewController {
                transactionVC.transactionViewModel?.getTransactions(first: 0, count: 20)
            }
            break
        case .balance:
            let detVC = storyboard.instantiateViewController(withIdentifier: "BalanceViewController")
            navController.pushViewController(detVC, animated: true)
            break
        case .exit:
            break
        case .orders:
             pushOrdersVC()
            break
        case .support:
            pushSupportVC()
            break
        case .transactions:
            pushTransactionsVC()
            break
        }
    }
    
    
}

extension MenuCoordinator {
    func buildMenuViewModel() -> MenuViewModel {
        let menuViewModel = MenuViewModel(loginData: data)
        return menuViewModel
    }
    
    func buildOrdersViewModel() -> OrdersViewModel {
        let ordersViewModel = OrdersViewModel()
        return ordersViewModel
    }
}

protocol EventHadlerDelegate: class {
    func handleEvent(event: MenuEvents)
}

enum MenuEvents {
    case orders
    case transactions
    case support
    case balance
    case exit
    case changeUser
}
