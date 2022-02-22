//
//  HomeDataSrc.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 15/12/2021.
//


import UIKit

class HomeDataSrc: NSObject {
    var viewModel: HomeVM!
}

let testName = ["Name1", "Name2", "Name3"]
let testDesc = ["Desc1", "Desc2", "Desc3"]
let testPrice = [6969, 69, 420]


let accountsType = ["Main", "Checking", "Savings"]
var numberOfAccounts:Int = 2
var accountBalance = [69.62, 420.69]


extension HomeDataSrc: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath)as? HomeCell else {return UITableViewCell()}
        
        cell.transactionName = testName[indexPath.row]
        cell.transactionType = testDesc[indexPath.row]
        cell.transactionPrice = "$\(String(testPrice[indexPath.row]))"
        cell.transactionLogo = "https://1000logos.net/wp-content/uploads/2016/10/Apple-logo.jpg"
        
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300.0;
//    }
    
    
}

extension HomeDataSrc:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        return
    }
}


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
