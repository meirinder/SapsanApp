//
//  CourierTableViewCell.swift
//  SapsanApp
//
//  Created by Savely on 24/02/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class CourierTableViewCell: FullOrderTableViewCell {

    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func setCell() {
        let attributes = fullOrderCellViewModel?.courierDict()
        phoneLabel.setHTMLFromString(text: attributes?["phoneText"]?.content ?? "")
        nameLabel.setHTMLFromString(text: attributes?["nameText"]?.content ?? "")
        phoneLabel.textAlignment = .right
        nameLabel.textAlignment = .right
        if let link = attributes?["photoLink"]?.content {
            photoImageView.downloaded(from: link)
        }
        
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

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
