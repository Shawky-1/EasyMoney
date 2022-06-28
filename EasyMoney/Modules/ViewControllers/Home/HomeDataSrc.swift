//
//  HomeDataSrc.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 15/12/2021.
//


import UIKit
import RxCocoa

class HomeDataSrc: NSObject {
    var viewModel: HomeVM!
    var onItemSelected: ((Int) -> Void)? = nil
}

let companyNames = ["StarBucks", "Amazon", "Nike", "Carrefour", "kentucky fried chicken", "Starbucks", "Jumia"]
let companyDesc = ["Late grande", "Large T-Shirt", "Fashonable shoes", "Groceries", "Medium chicken bucket", "Frappe Large", "Gaming headset"]
let companyPrices = [3.99, 20.32, 120.25, 250.95, 15.62, 4.82, 87.12]
let companyLogos = ["https://www.freepnglogos.com/uploads/starbucks-logo-png-transparent-0.png", "https://pngimg.com/uploads/amazon/amazon_PNG5.png", "https://pngimg.com/uploads/nike/nike_PNG11.png", "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Carrefour_logo.svg/1277px-Carrefour_logo.svg.png", "https://e7.pngegg.com/pngimages/267/774/png-clipart-colonel-sanders-kfc-fried-chicken-logo-restaurant-fried-chicken-food-text.png", "https://logos-world.net/wp-content/uploads/2020/09/Starbucks-Logo.png", "https://d1b3667xvzs6rz.cloudfront.net/2018/09/Jumia.png"]

//MARK: TableviewDataSource
extension HomeDataSrc: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyNames.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath)as? HomeCell else {return UITableViewCell()}
        
        cell.transactionName = companyNames[indexPath.row]
        cell.transactionType = companyDesc[indexPath.row]
        cell.transactionPrice = "$\(String(companyPrices[indexPath.row]))"
        cell.transactionLogo = companyLogos[indexPath.row]
        
        return cell
        
    }
    
}

//MARK: UITableViewDelegate
extension HomeDataSrc: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Nov - 2021"
        case 1:
            return "Dec = 2021"
        default:
            return String(section)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onItemSelected?(indexPath.row)

    }
}
