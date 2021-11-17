//
//  DataStore.swift
//  assignment8
//
//  Created by Deepansh Sachdeva on 11/14/21.
//

import Foundation

class DataStore {
    var categories:[Category] = []
    var companies:[Company]   = []
    var stocks:[Stock]        = []
    var customers:[Customer]  = []
    
    init() {
        let catg1 = Category(name: "Electronics")
        let catg2 = Category(name: "Grocery")
        let catg3 = Category(name: "Education")
        categories += [catg1, catg2, catg3]
        
        let comp1 = Company(name: "Apple", symbol: "APL", headquarter: "California", email: "hello@apple.com")
        let comp2 = Company(name: "Stop & Shop", symbol: "SNS", headquarter: "Massachusetts", email: "contact@sns.com")
        companies += [comp1,comp2]

        customers.append(Customer(firstName: "Deepansh", lastName: "Sachdeva", address: "Boston", contact: "1234567890", email: "deepansh@gmail.com"))
        customers.append(Customer(firstName: "Varidhi", lastName: "Garg", address: "Boston", contact: "9087654321", email: "darthvader@mail.com"))
        customers.append(Customer(firstName: "Aishwarya", lastName: "Kumar", address: "Connecticut", contact: "1023456789", email: "asiwayrya@test.com"))
        
        let s1 = Stock(name: "iPhone", company: comp1, lastTradePrice: 900.9, financialRating: 9, category: catg1)
        let s2 = Stock(name: "Banana", company: comp2, lastTradePrice: 5.1, financialRating: 5, category: catg2)
        stocks += [s1,s2]
    }
}

let ds = DataStore()
