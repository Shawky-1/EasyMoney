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
    

}

extension ReceiveVCDataSrc: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiveCell", for: indexPath)as? ReceiveCell else {return UITableViewCell()}
        let contact = viewModel.contacts[indexPath.row]
        let fullName = contact.firstName + " " + contact.lastName
        cell.name.text = fullName
        cell.number.text = contact.phoneNumber
        cell.contactLogo.image = viewModel.imageWith(name: fullName)
        
        
        return cell
    }
    
    
}


extension ReceiveVCDataSrc: UITableViewDelegate{
    
}
