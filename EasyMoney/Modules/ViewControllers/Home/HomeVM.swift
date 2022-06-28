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
import Contacts
import RealmSwift

class HomeVM: ViewModel {
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    var dataManager: DataManager
    var disposeBag: DisposeBag = .init()
    var refreshView = PublishSubject<Bool>()
    let database = Firestore.firestore()
    var phoneNumber = UserDefaults.standard.integer(forKey: "phoneNumber")
    var userData:User?
    var balance:Double?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
}

extension HomeVM {
    
    func viewDidLoad() {

    }
    @objc func signOut(){
        let firebaseAuth =  Auth.auth()
    do {
      try firebaseAuth.signOut()
        print("signed out sucessfuly!")
        UserDefaults.standard.set(nil, forKey: "email")
        UserDefaults.standard.set(nil, forKey: "firstName")
        UserDefaults.standard.set(nil, forKey: "lastName")
        UserDefaults.standard.set(nil, forKey: "email")
        UserDefaults.standard.set(nil, forKey: "birthDate")
        UserDefaults.standard.set(nil, forKey: "phoneNumber")
        UserDefaults.standard.set(nil, forKey: "loggedIn")


        
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
    }
    
    func getInfo() {
        let docRef = database.collection("Users/1061520610/Data").document("Info")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.balance = document.get("Balance")as? Double ?? 0
                self.userData?.firstName = document.get("FirstName") as? String ?? ""
                self.userData?.lastName = document.get("LastName") as? String ?? ""
            } else {
                print("Document does not exist")
            }
            
        }
    }
    
}
