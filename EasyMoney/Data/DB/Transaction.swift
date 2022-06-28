//
//  Transaction.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 27/06/2022.
//

import Foundation


struct Transaction {
    var transactionID: String
    var transactionAmmount: Double
    var transactionDate: Date
    var transferedTo: String
    var transferedFrom: String
    var transactionImage: String = ""

}
