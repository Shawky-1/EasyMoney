//
//  TransactionVM.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 06/03/2022.
//

import Foundation
import RxSwift


class TransactionVM: ViewModel {
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    var dataManager: DataManager
    var disposeBag: DisposeBag = .init()
    var refreshView = PublishSubject<Bool>()
    var containerView = UIView()
    
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
}

extension TransactionVM{
    
    func backSpace(text: String)-> String {
        var inputText: String = text
        inputText.remove(at: inputText.index(before: inputText.endIndex))
        
        return text
    }
}
