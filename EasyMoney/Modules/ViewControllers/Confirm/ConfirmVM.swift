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
import FirebaseDatabase
import FirebaseFirestore

class ConfirmVM: ViewModel {
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    var dataManager: DataManager
    var disposeBag: DisposeBag = .init()
    var refreshView = PublishSubject<Bool>()
    let database = Firestore.firestore()
    let ref = Database.database().reference()
    var profilePicture: UIImage = UIImage()
    var transactionAmmount:Double
    let contact:Contact
    let send:Bool
    var currentUpdatedBalance:Double = 0
    var otherUpdatedBalance:Double = 0
    let currentEmail = UserDefaults.standard.string(forKey: "email")
    var otherEmail:String = ""
    let balance = UserDefaults.standard.double(forKey: "balance")
    var onPopVC: (() -> Void)? = nil

        
    init(dataManager: DataManager, transactionAmmount:Double, contact:Contact, send:Bool) {
        self.dataManager = dataManager
        self.transactionAmmount = transactionAmmount
        self.contact = contact
        self.send = send
    }
}

extension ConfirmVM {
        
    func getData() {
        let docRef = database.collection("Users").whereField("PhoneNumber", isEqualTo: Int(removePrefix(number: contact.phoneNumber))!)
        
        docRef.getDocuments { snapshot, error in
            if let error = error{
                print(error.localizedDescription)
            }else {
                if snapshot!.documents.isEmpty {
                    NotifiyMessage.shared.toast(toastMessage: "User doesn't have the application")
                    return
                }
                
                for doc in snapshot!.documents{
                    let docID = doc.documentID
                    self.fetchDocData(docID: docID)
                }
            }
        }
                
    }
    
    func fetchDocData(docID: String){
        database.collection("Users/\(docID)/Data").getDocuments { (snapshot, error) in
            if let error = error{
                print(error.localizedDescription)
            } else {
                for document in snapshot!.documents{
                    let otherBalance = document.get("Balance")as? Double ?? 0
                    self.otherEmail = document.get("Email")as? String ?? ""
                    self.editBalance(currentUserBalance: self.balance,
                                otherUserBalance: otherBalance,
                                transactionAmmount: self.transactionAmmount,
                                send: self.send)
                }
            }
            
        }
    }
    
    func editBalance(currentUserBalance: Double, otherUserBalance: Double,transactionAmmount:Double , send:Bool){
        if send{
            if currentUserBalance < transactionAmmount{
                NotifiyMessage.shared.toast(toastMessage: "Insufficient balance")
                return
            } else if currentUserBalance >= transactionAmmount{
                self.currentUpdatedBalance = currentUserBalance - transactionAmmount
                self.otherUpdatedBalance = otherUserBalance + transactionAmmount
                self.writeTransactionInfo(thisEmail: self.currentEmail ?? "", otherEmail: self.otherEmail, transactionAmmount: self.transactionAmmount)
                self.updateCurrentBalance(email: self.currentEmail ?? "", balance: self.currentUpdatedBalance)
                self.updateOtherBalance(email: self.otherEmail, balance: self.otherUpdatedBalance)
                return
            }
        } else if !send{
            if otherUserBalance < transactionAmmount{
                NotifiyMessage.shared.toast(toastMessage: "Insufficient balance")
                return
            } else if otherUserBalance >= transactionAmmount{
                self.currentUpdatedBalance = currentUserBalance + transactionAmmount
                self.otherUpdatedBalance = otherUserBalance - transactionAmmount
                self.writeTransactionInfo(thisEmail: self.otherEmail, otherEmail: self.currentEmail ?? "", transactionAmmount: self.transactionAmmount)
                self.updateCurrentBalance(email: self.currentEmail ?? "", balance: self.currentUpdatedBalance)
                self.updateOtherBalance(email: self.otherEmail, balance: self.otherUpdatedBalance)
                return
            }
        }
        return
    }
    
    func writeTransactionInfo(thisEmail:String, otherEmail:String, transactionAmmount:Double){
        let ID = UUID().uuidString
        database.collection("Users/\(thisEmail)/TransactionHistory/").document(ID).setData([
            "TransactionAmmount": transactionAmmount,
            "TransferedTo": otherEmail,
            "TransferedFrom": thisEmail,
            "TransactionDate": Date(),
            "TransactionID": ID
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        database.collection("Users/\(otherEmail)/TransactionHistory/").document(ID).setData([
            "TransactionAmmount": transactionAmmount,
            "TransferedTo": otherEmail,
            "TransferedFrom": thisEmail,
            "TransactionDate": Date(),
            "TransactionID": ID
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        database.collection("Transactions").document("\(ID)").setData([
            "TransactionAmmount": transactionAmmount,
            "TransferedTo": otherEmail,
            "TransferedFrom": thisEmail,
            "TransactionDate": Date(),
            "TransactionID": ID
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    //MARK: Errorrrrrrr
    func updateCurrentBalance(email: String, balance: Double) {
        database.collection("Users/\(email)/Data").document("Info").updateData(["Balance" : balance])
        self.onPopVC!()
    }
    
    func updateOtherBalance(email: String, balance: Double) {
        database.collection("Users/\(email)/Data").document("Info").updateData(["Balance" : balance])
    }
    
    func imageWith(name: String?) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: 500, height: 500)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .lightGray
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 200)
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
    
    func setupTextLabel(Label: UILabel){
        if send {
            Label.text = "Would you like to send this ammount to \(contact.firstName) \(contact.lastName)?"
        } else {
            Label.text = "Would you like to receive this ammount from \(contact.firstName) \(contact.lastName)?"
        }
    }
    
    func removePrefix(number: String) -> String {
        let prefix = "+2" // What ever you want may be an array and step thru it
        guard number.hasPrefix(prefix) else { return number }
        return String(number.dropFirst(prefix.count).trimmingCharacters(in: .whitespacesAndNewlines))
    }
}

