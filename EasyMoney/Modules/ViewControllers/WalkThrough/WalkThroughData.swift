//
//  Data.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Alabiad on 8/29/21.
//

import Foundation
import UIKit

var slides:[walkthroughData] = []

struct data{
    static let image1 = #imageLiteral(resourceName: "1200px-Un1.svg")
    static let image2 = #imageLiteral(resourceName: "1200px-Deux.svg")
    static let image3 = #imageLiteral(resourceName: "1200px-Trois.svg")
    static var titleQuote1:String = "CHOOSE PRODUCT"
    static var titleQuote2:String = "PURCHASE"
    static var titleQuote3:String = "DELIVERY"
    static var descQuote1:String = "Choose a product from our various products that you'll have access to from various categories"
    static var descQuote2:String = "Select a PayTabs as your payment method and pay with either credit, debit or master card or any other type from our various types"
    static var descQuote3:String = "Get your order delivered at no time! Our delivery boys will get your order in less than 3 working days right at your door."
    
    init() {
        
    }
}

struct walkthroughData{
    
    let title:String
    let desc:String
    let image:UIImage
}

func setSlides(){
    slides = [walkthroughData(title: data.titleQuote1, desc: data.descQuote1, image: data.image1), walkthroughData(title: data.titleQuote2, desc: data.descQuote2, image: data.image2), walkthroughData(title: data.titleQuote3, desc: data.descQuote3, image: data.image3)]
}


