//
//  Customer.swift
//  assignment8
//
//  Created by Deepansh Sachdeva on 11/14/21.
//

import Foundation

class Customer: CustomStringConvertible {
    static var newId:Int = 1
    
    var id:Int
    var firstName:String
    var lastName:String
    var address:String
    var contact:String
    var email:String
    
    var orders:[Order]
    
    public var description: String { return self.firstName+" "+self.lastName }
    
    init(firstName:String, lastName:String, address:String, contact:String, email:String){
        self.id = Customer.newId
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.contact = contact
        self.email = email
        
        self.orders = []
        
        Customer.newId += 1
    }
    
    func addOrder(_ order: Order) {
        orders.insert(order, at: 0)
    }
    
    func getTotalInvestingAmount() -> Double {
        var sum = 0.0
        
        for order in self.orders {
            sum += order.buyAmount
        }
        
        return sum
    }
    
    func getTotalEarningAmount() -> Double {
        var sum = 0.0
        
        for order in self.orders {
            sum += (order.sellAmount ?? 0.0)
        }
        
        return sum
    }
}
