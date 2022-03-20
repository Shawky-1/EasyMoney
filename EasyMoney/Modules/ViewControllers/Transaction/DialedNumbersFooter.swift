//
//  DialedNumbersFooter.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 20/03/2022.
//

import Foundation
import UIKit

class DialedNumbersFooter: UICollectionReusableView{
    
    let sendButton = UIButton()
    let recieveButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let stackview = UIStackView(arrangedSubviews: [sendButton, recieveButton])
        stackview.cornerRadius = 25
        stackview.axis = .horizontal
        sendButton.backgroundColor = .blue
        recieveButton.backgroundColor = .orange
        stackview.fillSuperview(padding: .init(top: 0, left: 32, bottom: 0, right: 32))

        addSubview(stackview)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
