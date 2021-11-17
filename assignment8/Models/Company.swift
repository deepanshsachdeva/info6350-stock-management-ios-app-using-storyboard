//
//  Company.swift
//  assignment8
//
//  Created by Deepansh Sachdeva on 11/14/21.
//

import Foundation
import UIKit

class Company: CustomStringConvertible {
    static var newId:Int = 1
    
    var id:Int
    var name:String
    var symbol:String
    var headquarter:String
    var email:String
    var logo:UIImage
    
    public var description: String { return "\(self.name) (\(self.symbol))" }
    
    init(name:String, symbol:String, headquarter:String, email:String){
        self.id          = Company.newId
        self.name        = name
        self.symbol      = symbol
        self.headquarter = headquarter
        self.email       = email
        self.logo        = UIImage(named: "default_company")!
        
        Company.newId += 1
    }
}
