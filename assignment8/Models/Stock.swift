//
//  Stock.swift
//  assignment8
//
//  Created by Deepansh Sachdeva on 11/14/21.
//

import Foundation
import UIKit

class Stock: CustomStringConvertible {
    static var newId:Int = 1
    
    var id:Int
    var name:String
    var company:Company
    var lastTradePrice:Double
    var financialRating:Int
    var category:Category
    var logo:UIImage
    
    public var description: String { return self.name }
    
    init(name:String, company:Company, lastTradePrice:Double, financialRating:Int, category:Category){
        self.id              = Stock.newId
        self.name            = name
        self.company         = company
        self.lastTradePrice  = lastTradePrice
        self.financialRating = financialRating
        self.category        = category
        self.logo            = UIImage(named: "default_stock")!
        
        Stock.newId += 1
    }
}
