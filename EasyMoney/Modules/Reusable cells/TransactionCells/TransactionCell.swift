//
//  TransactionCell.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 06/03/2022.
//

import UIKit
import Kingfisher

class TransactionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var transactionImage:String? {
        didSet{
            imageView.image = UIImage(named: transactionImage ?? "RecieveMoney")
        }
    }
    
    var transactionTitle:String?{
        didSet{
            titleLabel.text = transactionTitle

        }
    }
}
