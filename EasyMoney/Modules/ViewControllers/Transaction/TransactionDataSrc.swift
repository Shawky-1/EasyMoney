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
        cell.digitsLabel.text = numbersArray[indexPath.item]
        cell.lettersLabel.text = String(indexPath.item)
        return cell
        
    }
}
//MARK: CollectionView Delegate
extension TransactionDatasrc: UICollectionViewDelegate {
    
    //MARK: header dequeue
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath)as? DialedNumbersHeader else {return UICollectionReusableView()}
            header.ammountLabel.text = dialedNumbersString
            
            return header
        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerReuseIdentifier, for: indexPath)as? DialedNumbersFooter else {return UICollectionReusableView()}
            return footer
            
        default:
            
            assert(false, "Unexpected element kind")
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.width, height: collectionView.height / 4.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let number = numbersArray[indexPath.item]
        
        
        switch dialedNumbersString.filter({ $0 == "." }).count {
        case 0:
            if dialedNumbersString == "" && number == "." {
                dialedNumbersString += "0"
                dialedNumbersString += number
            }
            else{
                dialedNumbersString += number
            }
        case 1:
            if (number == "."){
                print("String Already have a dot")
                
            }
            else {
                dialedNumbersString += number
                
            }
        default:
            return
        }
        collectionView.reloadData()
    }
    
    
}

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
