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
import Moya

class ReceiveVM: ViewModel {
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    var dataManager: DataManager
    var disposeBag: DisposeBag = .init()
    var refreshView = PublishSubject<Bool>()
    var ammount = 0
    var contactsName:[String] = []
    var contactsFamilyName:[String] = []
    var contactsNumber:[String] = []
    
    init(dataManager: DataManager, ammount: Int) {
        self.dataManager = dataManager
        self.ammount = 0
        
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
                print("Access Granted.")
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do {
                    try store.enumerateContacts(with: request) { contact, _ in
                        self.contactsName.append(contact.givenName)
                        self.contactsFamilyName.append(contact.familyName)
                        self.contactsNumber.append(contact.phoneNumbers.first?.value.stringValue ?? "")
                        
                    }
                } catch let err {
                    print("failed to enu contacts")
                }
                
                
            }
            else {
                print("Access denied.")
            }
        }
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
    
}
