//
//  OrderCreateViewController.swift
//  assignment8
//
//  Created by Deepansh Sachdeva on 11/15/21.
//

import UIKit
import CoreData

class OrderCreateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var customer: CustomerCD!
    
    var managedContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext!
    
    var stocks = DataStore.shared.getStocks()
    
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityInput: UITextField!
    @IBOutlet weak var stockPicker: UIPickerView!
    
    var selStock:StockCD!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        stockPicker.delegate = self
        stockPicker.dataSource = self
        
        customerLabel.text = "\(customer.firstName!+" "+customer.lastName!) (ID: \(customer.oid))"
        
        selStock = stocks[0]
        
        setFieldsFor(stock: selStock)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stocks.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stocks[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selStock = stocks[row]
        
        setFieldsFor(stock: selStock)
    }
    
    func setFieldsFor(stock: StockCD) {
        priceLabel.text = "Last Trade Price: $\(stock.lastTradePrice)"
    }
    
    @IBAction func doAction(_ sender: UIButton) {
        let quantity = Int(quantityInput.text!)
        
        guard quantity != nil else {
            let alert = UIAlertController(title: "Error", message: "quantity is missing/invalid", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let newOrder = OrderCD(context: managedContext)
        
        newOrder.customer = customer
        newOrder.stock = selStock
        newOrder.quantity = Int16(quantity!)
        
        DataStore.shared.addOrderItem(newOrder)
        
        let alert = UIAlertController(title: "Success", message: "order created", preferredStyle: UIAlertController.Style.alert)
        
        let successAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {_ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(successAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
