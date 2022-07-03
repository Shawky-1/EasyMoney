//
//  RecieveVM.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 09/05/2022.
//

import Foundation
import RxCocoa
import RxSwift
import Contacts
import ContactsUI
import Firebase

class ReceiveVM: ViewModel {
    var TransactionVM: TransactionVM!
    
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    var dataManager: DataManager
    var disposeBag: DisposeBag = .init()
    var refreshView = PublishSubject<Bool>()
    var ammount:Double
    var receiver:String = ""
    @Published var contacts = [Contact]()
    var selectedContact:Contact?
    var filteredUsers = [Contact]()
    let database = Firestore.firestore()
    var send = true

    let firstName = UserDefaults.standard.value(forKey: "firstName")
    let lastName = UserDefaults.standard.value(forKey: "lastName")
    let email = UserDefaults.standard.value(forKey: "email")
    
    init(dataManager: DataManager, ammount: Double, receiver: String) {
        self.dataManager = dataManager
        self.ammount = ammount
        self.receiver = receiver
    }
}

extension ReceiveVM {
    
    
    func fetchContacts(){
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { accessGranted, err in
            if let err = err {
                print("Failed to get contacts: ", err)
                return
            }
            if accessGranted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        if contact.phoneNumbers.first != nil{
                        self.contacts.append(Contact(firstName: contact.givenName,
                                                     lastName: contact.familyName,
                                                     phoneNumber: (contact.phoneNumbers[0].value).value(forKey: "digits") as! String))
                        self.contacts.sort(by: { $0.firstName < $1.firstName })
                        }
                        
                    })
                    
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
                
            } else {
                print("access denied")
            }
        }
        self.filteredUsers = self.contacts
    }
    
    func imageWith(name: String?) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .lightGray
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
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
    
    func imageText(name: String?) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: 50, height: 100)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .clear
        nameLabel.textColor = .lightGray
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        nameLabel.text = name
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
    
    func addLeftImageTo(Field: UITextField, Image: UIImage){
        let leftImageView = UIImageView(frame: CGRect(x: 5, y: 0, width: Image.size.width, height: Image.size.height))
        leftImageView.image = Image
        Field.leftView = leftImageView
        Field.leftViewMode = .always
    }
    
    func addLeftImageTo(Field: UISearchTextField, Image: UIImage){
        let leftImageView = UIImageView(frame: CGRect(x: 5, y: 0, width: Image.size.width, height: Image.size.height))
        leftImageView.image = Image
        Field.leftView = leftImageView
        Field.leftViewMode = .always
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
            "TransactionDate": Date()
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    func changeTitle() -> String{
        var title = ""
        (receiver == "To") ? (title = "Send") : (title = "Receive")
        (receiver == "To") ? (send = true) : (send = false)

        return title
    }
    
}
