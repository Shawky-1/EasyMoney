//
//  TransactionDataSrc.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 06/03/2022.
//

import Foundation
import UIKit



class TransactionDatasrc: NSObject {
    var viewModel: TransactionVM!
    
    var onNumberSelected: ((String) -> Void)? = nil
    var onDelString: ((String) -> Void)? = nil

}

let transactionTitles = ["Send Credit", "Request credit", "Scan QR-Code"]
let transactionImages = ["SendMoney", "RecieveMoney", "QRCode"]
var containerView = UIView()
let cellReuseIdentifier = "TransactionsNumPad"
let headerReuseIdentifier = "Header"
let footerReuseIdentifier = "Footer"

let numbersArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9",".", "0", ""]
let imageArray = ["", "", "", "", "", "", "", "", "","", "", "delete.left.fill"]

var dialedNumbersString = ""


//MARK: Collectionview Datasource
extension TransactionDatasrc: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)as? TransactionsNumPad else {return UICollectionViewCell()}
        if (indexPath.item <= 10){
        cell.digitsLabel.text = numbersArray[indexPath.item]
            
        }
        else if (indexPath.item == 11){
            cell.digitsLabel.isHidden = true
            cell.lettersLabel.isHidden = true
            cell.backgroundColor = .clear
            cell.backImage.sizeToFit()
            cell.backImage.image = UIImage(systemName: "delete.left.fill")
            
        }
        
        return cell
        
    }
}
//MARK: CollectionView Delegate
extension TransactionDatasrc: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let number = numbersArray[indexPath.item]
        if (indexPath.item <= 10) {
            onNumberSelected?(number)

        }
        else if (indexPath.item == 11) {
            onDelString?(number)
        }
        var backgroundColor = collectionView.cellForItem(at: indexPath)?.backgroundColor
        
        
    }
    
    
}
//MARK: CollectionView Layout
extension TransactionDatasrc: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftRightPadding = collectionView.frame.width * 0.15
        let interSpacing = collectionView.frame.width * 0.1
        let cellWidth = (collectionView.frame.width - 2 * leftRightPadding - 2 * interSpacing) / 3
        return CGSize(width: cellWidth , height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let leftRightPadding = collectionView.frame.width * 0.15
        
        return .init(top: 16, left: leftRightPadding, bottom: 16, right: leftRightPadding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
