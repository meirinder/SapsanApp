//
//  SupportAlertView.swift
//  SapsanApp
//
//  Created by Savely on 20/04/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class SupportAlertView: UIView {

    private var titles = ["Технические проблемы с личным кабинетом или приложением",
                          "Проблемы с оператором","Проблемы с курьером","Отзыв о работе","Другое"]
    var helpTypes: [HelpTypes]?
    weak var controller: UIViewController!

    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var subjectButton: UIButton!
    @IBOutlet weak var objectTextView: UITextView!
    private var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var subjectsTableView: UITableView!
    
    private var currentId = -1
    
    @IBOutlet weak var subjectTableViewHeightConstraint: NSLayoutConstraint!
    
    @IBAction func chooseSubjectAction(_ sender: UIButton) {
        if subjectTableViewHeightConstraint.constant == 0 {
            subjectTableViewHeightConstraint.constant = 250
        } else {
            subjectTableViewHeightConstraint.constant = 0
        }
    }
    
    @IBAction func writeAction(_ sender: Any) {
        NetWorker.sendInstructions(message: objectTextView.text, typeId: "\(currentId)") { (data) in
            //
        }
    }
    @IBAction func exitAction(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    @IBAction func endAction(_ sender: Any) {
        self.endEditing(true)
    }
    
    override func awakeFromNib() {
        subjectsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SubjectCell")
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
        subjectsTableView.delegate = self
        subjectsTableView.dataSource = self
        subjectLabel.layer.cornerRadius = 6
        subjectLabel.layer.borderColor = UIColor.white.cgColor
        subjectLabel.layer.borderWidth = 3
        writeButton.layer.cornerRadius = 6
        subjectTableViewHeightConstraint.constant = 0
        writeButton.isEnabled = false
        writeButton.alpha = 0.5
        objectTextView.isHidden = true
//        NotificationCenter.default.addObserver(self, selector: #selector(WriteSupportViewController.writeKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(WriteSupportViewController.writeKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

extension SupportAlertView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helpTypes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = helpTypes?[indexPath.row].value
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        writeButton.isEnabled = true
        writeButton.alpha = 1
        objectTextView.isHidden = false
        objectTextView!.layer.borderWidth = 1
        objectTextView!.layer.borderColor = UIColor(hexString: "ff1f007f").cgColor
        subjectTableViewHeightConstraint.constant = 0
        subjectLabel.text = helpTypes?[indexPath.row].value ?? ""
        currentId = helpTypes?[indexPath.row].id ?? -1
        //        subjectButton.setTitle(titles[indexPath.row], for: .normal)
        //        currentId = indexPath.row + 1
    }
    
    
    
    @objc func writeKeyboardWillShow(notification:NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.frame.origin.y >= 0{
                self.addGestureRecognizer(tapGesture)
                self.frame.origin.y -= keyboardSize.height/2
            }
        }
    }
    
    @objc func writeKeyboardWillHide(notification:NSNotification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.frame.origin.y < 0{
                self.removeGestureRecognizer(tapGesture)
                self.frame.origin.y = 0
            }
        }
    }

}
