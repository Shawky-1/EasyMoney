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
        return viewModel.contactsName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiveCell", for: indexPath)as? ReceiveCell else {return UITableViewCell()}
        let fullName = viewModel.contactsName[indexPath.row] + " " +  viewModel.contactsFamilyName[indexPath.row]
        cell.name.text = fullName
        cell.number.text = viewModel.contactsNumber[indexPath.row]
        cell.contactLogo.image = viewModel.imageWith(name: fullName)
        
        
        return cell
    }
    
    
}


extension ReceiveVCDataSrc: UITableViewDelegate{
    
}
