//
//  ViewModel.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 14/12/2021.
//

import Foundation
import RxSwift
import RxCocoa

public protocol ViewModel: AnyObject {
    var dataManager: DataManager { get set }
    var isLoading: PublishSubject<Bool> { get set }
    var displayError: PublishSubject<String> { get set }
    var disposeBag: DisposeBag { get set }
    func handleError(error: Error)
}

public extension ViewModel {
    func handleError(error: Error) {
        self.isLoading.onNext(false)
        if let error = error as? NetworkError {
            self.displayError.onNext(error.errorDescription ?? "")
            return
        }
        self.displayError.onNext(error.localizedDescription)
    }
}
