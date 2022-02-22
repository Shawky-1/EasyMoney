//
//  CardColelctionViewCell.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 22/02/2022.
//

import UIKit

class CardColelctionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var accountTypeLabel: UILabel!
    @IBOutlet weak var accountBalanceLabel: UILabel!

    var accountType:String?{
        didSet{
            accountTypeLabel.text = accountType

        }
    }
    
    var accountBalance:String?{
        didSet{
            accountBalanceLabel.text = accountBalance

        }
    }
}
