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
    
    

    
    func createSliderView(){
//        let window = UIApplication.shared.keyWindow
//        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
//        containerView.frame = TransactionVC.view.frame
//        
//        window?.addSubview(containerView)
    }
}
