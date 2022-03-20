//
//  HomeVM.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 15/12/2021.
//

import Foundation
import RxCocoa
import RxSwift
import FirebaseFirestore
import FirebaseAuth

class HomeVM: ViewModel {
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    var dataManager: DataManager
    var disposeBag: DisposeBag = .init()
    var refreshView = PublishSubject<Bool>()
    let database = Firestore.firestore()
        
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
}

extension HomeVM {
    
    func viewDidLoad() {
        let docRef = database.document("EasyMoney/Example")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else {return}
            print(data)
        }

    }

    func writeData(text:String){
        let docRef = database.document("EasyMoney/Example")
        docRef.setData(["Text":text])
    }
    
    @objc func signOut(){
        let firebaseAuth =  Auth.auth()
    do {
      try firebaseAuth.signOut()
        print("signed out sucessfuly!")
        UserDefaults.standard.set(nil, forKey: "email")
        
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
    }
    
}
