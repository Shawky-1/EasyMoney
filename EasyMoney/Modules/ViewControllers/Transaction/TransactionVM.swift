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
    private var receiver:String = String()
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
}

extension TransactionVM{
    
    func getReceiverData() -> String{
        return self.receiver
    }
    
    func setReceiverData(data: String){
        self.receiver = data
    }
    
    func backSpace(text: String)-> String {
        var inputText: String = text
        inputText.remove(at: inputText.index(before: inputText.endIndex))
        
        return text
    }
    
    
}
