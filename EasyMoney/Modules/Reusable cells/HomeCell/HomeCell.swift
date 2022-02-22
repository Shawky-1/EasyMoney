//
//  HomeCell.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 17/12/2021.
//

import UIKit
import Kingfisher


class HomeCell: UITableViewCell {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var transactionName:String?{
        didSet{
            name.text = transactionName
            
        }
    }
    
    var transactionType:String?{
        didSet{
            type.text = transactionType

        }
    }

    var transactionPrice:String?{
        didSet{
            price.text = transactionPrice

        }
    }

    var transactionLogo:String?{
        didSet{
            logo.kf.indicatorType = .activity
            logo.kf.setImage(with: URL(string: transactionLogo ?? ""))
        }
    }
    
    
    
    
    
    
}
