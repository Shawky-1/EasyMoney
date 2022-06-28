//
//  ConfirmVM.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 25/06/2022.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit
import Firebase


class ConfirmVM: ViewModel {
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    var dataManager: DataManager
    var disposeBag: DisposeBag = .init()
    var refreshView = PublishSubject<Bool>()
    let database = Firestore.firestore()
    var profilePicture: UIImage = UIImage()
    var transactionAmmount:Double
    let contact:Contact
//    var otherParty:String
        
    init(dataManager: DataManager, transactionAmmount:Double, contact:Contact) {
        self.dataManager = dataManager
        self.transactionAmmount = transactionAmmount
        self.contact = contact
    }
}

extension ConfirmVM {
    
    func retriveData() {
        
        // read the documents at a specific path
        
        database.collection("Users").getDocuments { snapshot, error in
            
            // check for errors
            if error == nil {
                // no errors
                if let snapshot = snapshot {
                    // get all the documents
                    snapshot.documents.map { d in
                        return User(id: d.documentID
                                    , balace: d["Balance"] as? Double ?? 0,
                                    birthDate: d["BirthDate"]as? Date ?? Date(),
                                    email: d["Email"] as? String ?? "",
                                    firstName: d["FirstName"] as? String ?? "",
                                    lastName: d["LastName"] as? String ?? "")
                    }
                }
                
            } else {
                // handle the error
            }
        }
        
    }
    

    func writeTransactionInfo(thisEmail:String, otherEmail:String, transactionAmmount:Int){
        let ID = UUID().uuidString
        database.collection("Users/\(String(thisEmail))/TransactionHistory/").document(ID).setData([
            "TransactionAmmount": transactionAmmount,
            "Transferedto": otherEmail,
            "TransactionDate": Date(),
            "TransactionID": ID
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        database.collection("Transactions/").document("\(ID)").setData([
            "TransactionAmmount": transactionAmmount,
            "Transferedto": otherEmail,
            "Transferedfrom": UserDefaults.standard.value(forKey: "email") as Any,
            "TransactionDate": Date()
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
}
