//
//  TransactionVM.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 02/07/2022.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class TransactionDetailsVM: ViewModel {
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    var dataManager: DataManager
    var disposeBag: DisposeBag = .init()
    var refreshView = PublishSubject<Bool>()
    var transaction:Transaction
        
    init(dataManager: DataManager, transaction: Transaction) {
        self.dataManager = dataManager
        self.transaction = transaction
    }
}

extension TransactionDetailsVM {

    func setupLabels(transactionIDLbl: UILabel, transferedFromLbl: UILabel, transferedToLbl: UILabel, transactionDateLbl: UILabel, transactionAmmountLbl: UILabel) {
        transactionIDLbl.text = self.transaction.transactionID
        transferedFromLbl.text = self.transaction.transferedFrom
        transferedToLbl.text = self.transaction.transferedTo
        transactionDateLbl.text = self.transaction.transactionDate
        transactionAmmountLbl.text = "EGP \(self.transaction.transactionAmmount)"

    }
    
    func imageWith(name: String?) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .random
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 120)
        var initials = ""
        if let initialsArray = name?.components(separatedBy: " ") {
            if let firstWord = initialsArray.first {
                if let firstLetter = firstWord.first {
                    initials += String(firstLetter).capitalized }
            }
            if initialsArray.count > 1, let lastWord = initialsArray.last {
                if let lastLetter = lastWord.first { initials += String(lastLetter).capitalized
                }
            }
        } else {
            return nil
        }
        nameLabel.text = initials
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }

    
}
