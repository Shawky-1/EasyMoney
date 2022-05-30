//
//  Contact.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 13/05/2022.
//

import Foundation


struct Contact: Identifiable, Hashable {
    var id = UUID()
    var firstName: String //= "No firstName"
    var lastName: String //= "No lastName"
    var phoneNumber: String //= []

}
