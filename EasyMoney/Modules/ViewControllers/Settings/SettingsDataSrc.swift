//
//  SettingsDataSrc.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 26/02/2022.
//

import Foundation
import UIKit

class SettingsDataSrc: NSObject {
    var viewModel: SettingsVM!
    

}

let dataSettings = ["About", "Transaction History", "Settings", "Logout"]

extension SettingsDataSrc: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)as? SettingsCell else {return UITableViewCell()}

        cell.settingsLabel = dataSettings[indexPath.row]
        
        
        return cell
    }
    
    
}
