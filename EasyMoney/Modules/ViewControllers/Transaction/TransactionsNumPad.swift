//
//  TransactionsNumPad.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 11/03/2022.
//

import UIKit

class TransactionsNumPad: UICollectionViewCell {
    
    let digitsLabel = UILabel()
    let lettersLabel = UILabel()
    let backImage = UIImageView()
    let defaultColor = UIColor(white: 0.92, alpha: 1)
    
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? .darkGray : UIColor(white: 0.92, alpha: 1)
        }
    }
    override var isSelected: Bool{
        didSet{
            backgroundColor = isHighlighted ? .darkGray : UIColor(white: 0.92, alpha: 1)
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = defaultColor
        digitsLabel.font = UIFont.systemFont(ofSize: 32)
        digitsLabel.textAlignment = .center
        
        lettersLabel.font = UIFont.boldSystemFont(ofSize: 10)
        lettersLabel.textAlignment = .center
        
        backImage.contentMode = .scaleToFill
        
        let stackView = UIStackView(arrangedSubviews: [digitsLabel, lettersLabel])
        stackView.axis = .vertical
        
        addSubview(backImage)
        addSubview(stackView)
        stackView.centerInSuperview()
        backImage.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)

        backImage.centerInSuperview()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
