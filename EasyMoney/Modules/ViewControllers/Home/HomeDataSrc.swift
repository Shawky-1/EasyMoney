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


let accountsType = ["Main", "Checking", "Savings"]
var numberOfAccounts:Int = 2
var accountBalance = [69.62, 420.69]

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

//MARK: UICollectionViewDataSource
extension HomeDataSrc:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfAccounts
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardColelctionViewCell", for: indexPath)as? CardColelctionViewCell else {return UICollectionViewCell()}
        
        cell.accountBalance = "\(String(accountBalance[indexPath.row]))$"
        cell.accountType = "\(accountsType[indexPath.row]) account"
        
        return cell

    }
}
//MARK: UICollectionViewDelegate
extension HomeDataSrc: UICollectionViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
}
//MARK: UICollectionViewDelegateFlowLayout
extension HomeDataSrc: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width - 5
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
}
