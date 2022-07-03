//
//  RecieveDataSrc.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 09/05/2022.
//

import Foundation
import UIKit

class ReceiveVCDataSrc: NSObject {
    var viewModel: ReceiveVM!
    var onItemSelected: ((Contact) -> Void)? = nil
    var onReloadData: (() -> Void)? = nil
    var onContinueShow: (() -> Void)? = nil
    

}

extension ReceiveVCDataSrc: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiveCell", for: indexPath)as? ReceiveCell else {return UITableViewCell()}
        let contact = viewModel.filteredUsers[indexPath.row]
        let fullName = contact.firstName + " " + contact.lastName
        cell.name.text = fullName
        cell.number.text = String(contact.phoneNumber)
        cell.contactLogo.image = viewModel.imageWith(name: fullName)
        return cell
    }
}

extension ReceiveVCDataSrc: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = viewModel.filteredUsers[indexPath.row]
        viewModel.selectedContact = contact
        tableView.deselectRow(at: indexPath, animated: true)
        onItemSelected?(contact)
    }
    
}

extension ReceiveVCDataSrc: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filteredUsers = []
        
        if searchText == "" {
            viewModel.filteredUsers = viewModel.contacts
            onContinueShow?()
            
        }
        else{
            for filteredUser in viewModel.contacts {
                if filteredUser.firstName.lowercased().contains(searchText.lowercased()) {
                    viewModel.filteredUsers.append(filteredUser)
                }
            }
        }
        onReloadData?()
    }
    
}

extension ReceiveVCDataSrc: UITextFieldDelegate{
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
