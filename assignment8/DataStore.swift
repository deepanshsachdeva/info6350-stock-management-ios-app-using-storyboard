//
//  DataStore.swift
//  assignment8
//
//  Created by Deepansh Sachdeva on 11/14/21.
//

import Foundation
import CoreData
import UIKit

class DataStore {
    var categories:[Category] = []
    var companies:[Company]   = []
    var stocks:[Stock]        = []
    var customers:[Customer]  = []
    
    static let shared = DataStore()
    
    private var nextId:Int16 = 0
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        cleanDB()
        
        initDB()
    }
    
    func getNextId() -> Int16 {
        nextId += 1
        return nextId
    }
    
    // MARK: sample data
    func cleanDB() {
        print("cleaning DB...")
        
        let cdCategories = getCategories()
        for category in cdCategories {
            managedContext.delete(category)
        }
        
        let cdCompanies = getCompanies()
        for company in cdCompanies {
            managedContext.delete(company)
        }
        
        let cdStocks = getStocks()
        for stock in cdStocks {
            managedContext.delete(stock)
        }
        
        let cdCustomers = getCustomers()
        for customer in cdCustomers {
            managedContext.delete(customer)
        }
        
        print("cleaning DB done")
    }
    
    func initDB() {
        let catg1 = CategoryCD(context: managedContext)
        catg1.name = "Electronics"
        addCategoryItem(catg1)
        
        let catg2 = CategoryCD(context: managedContext)
        catg2.name = "Grocery"
        addCategoryItem(catg2)
        
        let catg3 = CategoryCD(context: managedContext)
        catg3.name = "Education"
        addCategoryItem(catg3)
        
        let comp1 = CompanyCD(context: managedContext)
        comp1.name = "Apple"
        comp1.symbol = "APL"
        comp1.headquarter = "California"
        comp1.email = "hello@apple.com"
        comp1.logo = UIImage(named: "default_company")?.pngData()
        addCompanyItem(comp1)
        
        let comp2 = CompanyCD(context: managedContext)
        comp2.name = "Stop & Shop"
        comp2.symbol = "SNS"
        comp2.headquarter = "Massachusetts"
        comp2.email = "contact@sns.com"
        comp2.logo = UIImage(named: "default_company")?.pngData()
        addCompanyItem(comp2)
        
        let stock1 = StockCD(context: managedContext)
        stock1.name = "iPhone"
        stock1.company = comp1
        stock1.category = catg1
        stock1.lastTradePrice = 900.9
        stock1.financialRating = 9
        stock1.logo = UIImage(named: "default_stock")?.pngData()
        addStockItem(stock1)
        
        let stock2 = StockCD(context: managedContext)
        stock2.name = "Banana"
        stock2.company = comp2
        stock2.category = catg2
        stock2.lastTradePrice = 5.1
        stock2.financialRating = 5
        stock2.logo = UIImage(named: "default_stock")?.pngData()
        addStockItem(stock2)
        
        let cust1 = CustomerCD(context: managedContext)
        cust1.firstName = "Deepansh"
        cust1.lastName = "Sachdeva"
        cust1.address = "Boston"
        cust1.contact = "1234567890"
        cust1.email = "deepansh@gmail.com"
        addCustomerItem(cust1)
        
        let cust2 = CustomerCD(context: managedContext)
        cust2.firstName = "Abhinav"
        cust2.lastName = "Gupta"
        cust2.address = "California"
        cust2.contact = "9876543210"
        cust2.email = "gupta@mit.edu"
        addCustomerItem(cust2)
        
        let cust3 = CustomerCD(context: managedContext)
        cust3.firstName = "Priya"
        cust3.lastName = "Roy"
        cust3.address = "India"
        cust3.contact = "6789054321"
        cust3.email = "pre@gmail.com"
        addCustomerItem(cust3)
        
        saveContext()
    }
    
    // MARK: categories tasks
    func addCategoryItem(_ category: CategoryCD) {
        category.oid = getNextId()
        
        do {
            managedContext.insert(category)
            try managedContext.save()
        } catch {
            fatalError("Error saving context: \(error)")
        }
    }
    
    func removeCategoryItem(_ category : CategoryCD) {
        do {
            managedContext.delete(category)
            try managedContext.save()
        } catch {
            fatalError("Error saving context: \(error)")
        }
    }
    
    func getCategories() -> [CategoryCD] {
        var categories:[CategoryCD] = []
        
        let fetchRequest: NSFetchRequest<CategoryCD> = CategoryCD.fetchRequest()
        
        print("fetching categories...")
        
        do {
            categories = try (self.managedContext.fetch(fetchRequest)) as [CategoryCD]
        } catch {
            fatalError("Error retrieving categories data: \(error)")
        }
        
        print("categories data fetched")
        
        return categories
    }
    
    // MARK: companies tasks
    func addCompanyItem(_ company: CompanyCD) {
        company.oid = getNextId()
        
        do {
            managedContext.insert(company)
            try managedContext.save()
        } catch {
            fatalError("Error saving context: \(error)")
        }
    }
    
    func removeCompanyItem(_ company : CompanyCD) {
        do {
            managedContext.delete(company)
            try managedContext.save()
        } catch {
            fatalError("Error saving context: \(error)")
        }
    }
    
    func getCompanies() -> [CompanyCD] {
        var companies:[CompanyCD] = []
        
        let fetchRequest: NSFetchRequest<CompanyCD> = CompanyCD.fetchRequest()
        
        print("fetching companies...")
        
        do {
            companies = try (self.managedContext.fetch(fetchRequest)) as [CompanyCD]
        } catch {
            fatalError("Error retrieving companies data: \(error)")
        }
        
        print("companies data fetched")
        
        return companies
    }
    
    // MARK: stocks tasks
    
    func addStockItem(_ stock: StockCD) {
        stock.oid = getNextId()
        
        do {
            managedContext.insert(stock)
            try managedContext.save()
        } catch {
            fatalError("Error saving context: \(error)")
        }
    }
    
    func removeStockItem(_ stock: StockCD) {
        do {
            managedContext.delete(stock)
            try managedContext.save()
        } catch {
            fatalError("Error saving context: \(error)")
        }
    }
    
    func getStocks() -> [StockCD] {
        var stocks:[StockCD] = []
        
        let fetchRequest: NSFetchRequest<StockCD> = StockCD.fetchRequest()
        
        print("fetching stocks...")
        
        do {
            stocks = try (self.managedContext.fetch(fetchRequest)) as [StockCD]
        } catch {
            fatalError("Error retrieving companies data: \(error)")
        }
        
        print("stocks data fetched")
        
        return stocks
    }
    
    // MARK: customer tasks
    func addCustomerItem(_ customer: CustomerCD) {
        customer.oid = getNextId()
        
        do {
            managedContext.insert(customer)
            try managedContext.save()
        } catch {
            fatalError("Error saving context: \(error)")
        }
    }
    
    func removeCustomerItem(_ customer: CustomerCD) {
        do {
            managedContext.delete(customer)
            try managedContext.save()
        } catch {
            fatalError("Error saving context: \(error)")
        }
    }
    
    func getCustomers() -> [CustomerCD] {
        var customers:[CustomerCD] = []
        
        let fetchRequest: NSFetchRequest<CustomerCD> = CustomerCD.fetchRequest()
        
        print("fetching customers...")
        
        do {
            customers = try (self.managedContext.fetch(fetchRequest)) as [CustomerCD]
        } catch {
            fatalError("Error retrieving companies data: \(error)")
        }
        
        print("customers data fetched")
        
        return customers
    }
    
    // MARK: common tasks
    func saveContext() {
        print("saving context...")
        do {
            try managedContext.save()
        } catch {
            fatalError("Error saving context: \(error)")
        }
        print("context saved successfully!")
    }
}

let ds = DataStore.shared
