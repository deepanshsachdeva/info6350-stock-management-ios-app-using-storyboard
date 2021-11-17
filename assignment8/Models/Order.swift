//
//  Order.swift
//  assignment8
//
//  Created by Deepansh Sachdeva on 11/15/21.
//

import Foundation


class Order: CustomStringConvertible {
    static var newId:Int = 1
    
    var id:Int
    var buyDate:Date
    var sellDate:Date? = nil
    var customer:Customer
    var stock: Stock
    var quantity: Int
    
    var buyPrice: Double
    var buyAmount:Double
    var sellPrice:Double? = nil
    var sellAmount:Double? = nil
    
    public var description: String { return "Order ID: \(self.id)" }
    
    init(customer: Customer, stock: Stock, quantity: Int) {
        self.id = Order.newId
        self.buyDate = Date()
        
        self.customer = customer
        self.stock = stock
        self.quantity = quantity
        
        self.buyPrice = stock.lastTradePrice
        self.buyAmount = stock.lastTradePrice * Double(quantity)
        
        Order.newId += 1
    }
    
    func sell() {
        if !self.isSold() {
            self.sellPrice = stock.lastTradePrice
            self.sellAmount = self.getCurrentValue()
            self.sellDate = Date()
        }
    }
    
    func getEarning() -> Double {
        if sellAmount != nil {
            return sellAmount! - buyAmount
        }
            
        return -1
    }
    
    func isSold() -> Bool {
        return (sellDate != nil)
    }
    
    func getCurrentValue() -> Double {
        return self.stock.lastTradePrice * Double(self.quantity)
    }
}
