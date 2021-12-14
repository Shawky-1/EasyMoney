//
//  WalkThroughCell.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 12/12/2021.
//

import UIKit

class WalkThroughCell: UICollectionViewCell {
    
    static let identifier = String(describing: WalkThroughCell.self)
    
    @IBOutlet weak var slideDescLabel: UILabel!
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var slideImageView: UIImageView!
    
    func setup(_ slide:walkthroughData){
        slideImageView.image = slide.image
        slideTitleLabel.text = slide.title
        slideDescLabel.text  = slide.desc
        
    }
}
