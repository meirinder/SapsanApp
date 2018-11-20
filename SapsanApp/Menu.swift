//
//  Menu.swift
//  SapsanApp
//
//  Created by Savely on 03.11.2018.
//  Copyright © 2018 Sapsan. All rights reserved.
//

import UIKit

class Menu: UIViewController {

    
       var menuVC :MenuViewController!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  showMenu()
        hideMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuVC =  (self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuViewController)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        swipeRight.direction = .right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
        swipeLeft.direction = .left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
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
    
    func showMenu() {
        UIView.animate(withDuration: 0.3){
            self.menuVC.view.frame = CGRect(x: 0,
                                            y: UIScreen.main.bounds.minY ,
                                            width: UIScreen.main.bounds.size.width,
                                            height: UIScreen.main.bounds.size.height)
            self.addChild(self.menuVC)
            self.view.addSubview(self.menuVC.view)
            AppDelegate.isMenuVC = false
        }
    }
    
    func hideMenu() {
        UIView.animate(withDuration: 0.3, animations: {
            self.menuVC.view.frame = CGRect(x: -UIScreen.main.bounds.size.width,
                                            y: UIScreen.main.bounds.minY,
                                            width: UIScreen.main.bounds.size.width,
                                            height: UIScreen.main.bounds.size.height)
            
        }){ (finished) in self.menuVC.view.removeFromSuperview()
            AppDelegate.isMenuVC = true
        }
    }
}
