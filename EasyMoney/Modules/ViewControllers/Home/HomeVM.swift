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
    var transaction = [Transaction]()
    var onFinishTransactions: (() -> Void)? = nil
    
    init(dataManager: DataManager, balance: Double) {
        self.dataManager = dataManager
        self.balance = balance
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
        UserDefaults.standard.set(false, forKey: "loggedIn")


        
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
    }
    
    
    func getInfo(balanceLbl: UILabel, welcomeLbl: UILabel) {
        let database = Firestore.firestore()
        let email = UserDefaults.standard.string(forKey: "email")
        let docRef = database.collection("Users/\(email ?? "ahmed@gmail.com")/Data").document("Info")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let firstName = document.get("FirstName")as? String ?? ""
                let lastName = document.get("LastName")as? String ?? ""
                let balance = document.get("Balance")as? Double ?? 0
                let formattedBalance: String = String(format: "%.2f", balance)
                
                balanceLbl.text = "EGP \(String(formattedBalance))"
                welcomeLbl.text = "Welcome \(firstName) \(lastName)"
                
                UserDefaults.standard.set(balance, forKey: "balance")
            } else {
                print("Document does not exist", UserDefaults.standard.string(forKey: "email") as Any)
            }
            
        }
    }
    
    func getTransactions(){
        let email = UserDefaults.standard.string(forKey: "email")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        database.collection("Users/\(email ?? "ahmed@gmail.com")/TransactionHistory").getDocuments { (snapshot, error) in
            if let error = error{
                print(error.localizedDescription)
            } else {
                for document in snapshot!.documents{
                    var strDate = ""
                    let transferedFrom = document.get("TransferedFrom")as? String ?? ""
                    let transferedTo = document.get("TransferedTo")as? String ?? ""
                    let transactionAmmount = document.get("TransactionAmmount")as? Double ?? 0
                    let transactionID = document.get("TransactionID")as? String ?? ""
                    if let transactionDate = document.get("TransactionDate") as? Timestamp {
                        let date = transactionDate.dateValue()
                        dateFormatter.dateStyle = .medium
                        dateFormatter.timeStyle = .short
                        strDate = "\(dateFormatter.string(from: date))"
                    }
                    self.transaction.append(Transaction(transactionID: transactionID, transactionAmmount: transactionAmmount, transactionDate: strDate, transferedTo: transferedTo, transferedFrom: transferedFrom))
                }
            }
            self.transaction = self.transaction.sorted(by: { $0.transactionDate.compare($1.transactionDate) == .orderedDescending })

            self.refreshView.onNext(true)
        }
    }
    
    func getTotalTransaction() -> Int{
        return self.transaction.count
    }
    
    
    func imageWith(name: String?) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .random
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 120)
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
    
}
