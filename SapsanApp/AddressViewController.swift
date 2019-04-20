//
//  AddressViewController.swift
//  SapsanApp
//
//  Created by Savely on 21/03/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController {

    
    weak var delegate: AddressVCDelegate?
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    var addresses = [Address]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let t = Address()
        t.text = "dasfafas"
        addresses.append(t)
        let r = Address()
        r.text = "asdadasfdsfafadfsfasdjlf ds fdsk kha fkds kfa jfksja ba fdsa fhksad f bhds hfkajs fksdav fsadkj fjdsa jfasfsa s fjh dsf hdksa sk fks jfjs fjsa fsdj fsd js f ds fs fjsad fjbs fjs fs fads fsad as dfsad "
        addresses.append(r)
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    @IBAction func editingChangeAction(_ sender: UITextField) {
        NetWorker.getAddresses(address: sender.text!) { (data) in
            self.addresses = JSONWorker.parseAdresses(data: data)
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
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

extension AddressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell", for: indexPath)
        cell.textLabel?.text = addresses[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.popToThisVC()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
