//
//  HomeViewController.swift
//  SapsanApp
//
//  Created by Savely on 29.10.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//


import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var itemStore : [OrderItem] = []


    
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    
    var menuVC :MenuViewController!
    
    
    override func viewWillAppear(_ animated: Bool) {
        showMenu()
        hideMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  ---------------------  test values
        let item = OrderItem(date: "16/10/2016",cleanPrice: "100",fullPrice: "200",status: "Выполнено",
                             timeStart: "12:30",timeEnd: "13:00",fromAdress: "Пархоменко 72",toAdress: "Титова 10")
        itemStore.append(item)
        //-------------------------
        
        menuVC =  (self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuViewController)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        swipeRight.direction = .right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        swipeLeft.direction = .left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        
        orderTableView.delegate = self
        orderTableView.dataSource = self
    }
    
    
    @objc func handleSwipe(gesture : UISwipeGestureRecognizer){
        switch gesture.direction {
        case UISwipeGestureRecognizer.Direction.right:
            showMenu()
            break
        case UISwipeGestureRecognizer.Direction.left:
            hideMenu()
            break
        default: break
            
        }
    }
    
    @IBAction func menuBarButtonItem(_ sender: Any) {
        if AppDelegate.isMenuVC{
            showMenu()
        }else{
            hideMenu()
        }
        
    }
    
    func showMenu() {
        UIView.animate(withDuration: 0.3){
            self.menuVC.view.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.size.width,
                                            height: UIScreen.main.bounds.size.height)
            self.addChild(self.menuVC)
            self.view.addSubview(self.menuVC.view)
            AppDelegate.isMenuVC = false
        }
    }

    func hideMenu() {
        UIView.animate(withDuration: 0.3, animations: {
            self.menuVC.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 60,
                                            width: UIScreen.main.bounds.size.width,
                                            height: UIScreen.main.bounds.size.height)
            
        }){ (finished) in self.menuVC.view.removeFromSuperview()
            AppDelegate.isMenuVC = true
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderTableView.dequeueReusableCell(withIdentifier: "OrderCell") as! OrderTableViewCell
   //     cell.dateLabel.text = itemStore[indexPath.row].date
        cell.cleanPriceLabel.text = itemStore[indexPath.row].cleanPrice
        cell.fullPriceLabel.text = itemStore[indexPath.row].fullPrice
        cell.statusLabel.text = itemStore[indexPath.row].status
        cell.timeStartLabel.text = itemStore[indexPath.row].timeStart
        cell.timeEndLabel.text = itemStore[indexPath.row].timeEnd
        cell.fromAdressLabel.text = itemStore[indexPath.row].fromAdress
        cell.toAdressLabel.text = itemStore[indexPath.row].toAdress
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  100
    }
}

