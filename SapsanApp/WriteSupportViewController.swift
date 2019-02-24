//
//  WriteSupportViewController.swift
//  SapsanApp
//
//  Created by Savely on 24/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class WriteSupportViewController: UIViewController {
    
    private var titles = ["Технические проблемы с личным кабинетом или приложением",
                          "Проблемы с оператором","Проблемы с курьером","Отзыв о работе","Другое"]
    
    @IBOutlet weak var subjectButton: UIButton!
    @IBOutlet weak var objectTextView: UITextView!
    private var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var subjectsTableView: UITableView!
    
    @IBOutlet weak var subjectTableViewHeightConstraint: NSLayoutConstraint!
    
    @IBAction func chooseSubjectAction(_ sender: UIButton) {
        if subjectTableViewHeightConstraint.constant == 0 {
            subjectTableViewHeightConstraint.constant = 250
        } else {
            subjectTableViewHeightConstraint.constant = 0
        }
    }
    
    @IBAction func writeAction(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        subjectsTableView.delegate = self
        subjectsTableView.dataSource = self
        subjectTableViewHeightConstraint.constant = 0
        writeButton.isEnabled = false
        writeButton.alpha = 0.5
        objectTextView.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(WriteSupportViewController.writeKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(WriteSupportViewController.writeKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
     }
    
}

extension WriteSupportViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectCell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        writeButton.isEnabled = true
        writeButton.alpha = 1
        objectTextView.isHidden = false
        objectTextView!.layer.borderWidth = 1
        objectTextView!.layer.borderColor = UIColor(hexString: "ff1f007f").cgColor
        subjectTableViewHeightConstraint.constant = 0
        subjectButton.setTitle(titles[indexPath.row], for: .normal)
    }
    
    
    @objc func writeKeyboardWillShow(notification:NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y >= 0{
                view.addGestureRecognizer(tapGesture)
                self.view.frame.origin.y -= keyboardSize.height/2 + 100
            }
        }
    }
    
    @objc func writeKeyboardWillHide(notification:NSNotification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y < 0{ 
                view.removeGestureRecognizer(tapGesture)
                self.view.frame.origin.y = 0
            }
        }
    }
}
