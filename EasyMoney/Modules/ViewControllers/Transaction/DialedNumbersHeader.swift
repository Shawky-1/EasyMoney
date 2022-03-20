//
//  DialedNumbersHeader.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 14/03/2022.
//

import UIKit

class DialedNumbersHeader: UICollectionReusableView {
    
    let ammountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        ammountLabel.text = "123"
        ammountLabel.textAlignment = .center
        ammountLabel.adjustsFontSizeToFitWidth = true
        
        ammountLabel.font = UIFont.systemFont(ofSize: 32)
        ammountLabel.font = UIFont.boldSystemFont(ofSize: 32)

        addSubview(ammountLabel)
        ammountLabel.fillSuperview(padding: .init(top: 0, left: 32, bottom: 0, right: 32))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
