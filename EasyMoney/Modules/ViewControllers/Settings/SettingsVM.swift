//
//  SettingsVM.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 26/02/2022.
//

import Foundation
import RxCocoa
import RxSwift

class SettingsVM: ViewModel {
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    var dataManager: DataManager
    var disposeBag: DisposeBag = .init()
    var refreshView = PublishSubject<Bool>()
        
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
}

extension SettingsVM {

    
}
