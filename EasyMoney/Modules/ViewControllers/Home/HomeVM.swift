//
//  HomeVM.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 15/12/2021.
//

import Foundation
import RxCocoa
import RxSwift

class HomeVM: ViewModel {
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    var dataManager: DataManager
    var disposeBag: DisposeBag = .init()
    var refreshView = PublishSubject<Bool>()
        
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
}

extension HomeVM {

    
}
