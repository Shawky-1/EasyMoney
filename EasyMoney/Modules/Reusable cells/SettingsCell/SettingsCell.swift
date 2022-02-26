//
//  SettingsCell.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 26/02/2022.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    
    var settingsLogo:String? {
        didSet{
            logo.kf.indicatorType = .activity
            logo.kf.setImage(with: URL(string: settingsLogo ?? ""))
        }
    }
    
    var settingsLabel:String?{
        didSet{
            title.text = settingsLabel

        }
    }
    
    
}
