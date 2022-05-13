//
//  ReceiveCell.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 12/05/2022.
//

import UIKit
import Kingfisher

class ReceiveCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var contactLogo: UIImageView!

    var contactImage:String? {
        didSet{
            contactLogo.kf.indicatorType = .activity
            contactLogo.kf.setImage(with: URL(string: contactImage ?? ""))
        }
    }
    
    var nameLabel:String?{
        didSet{
            name.text = nameLabel

        }
    }
    var numberLabel:String?{
        didSet{
            number.text = numberLabel

        }
    }
}
