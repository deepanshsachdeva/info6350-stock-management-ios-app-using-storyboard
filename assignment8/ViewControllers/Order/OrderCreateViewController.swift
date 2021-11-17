//
//  OrderCreateViewController.swift
//  assignment8
//
//  Created by Deepansh Sachdeva on 11/15/21.
//

import UIKit

class OrderCreateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var customer: Customer!
    
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityInput: UITextField!
    @IBOutlet weak var stockPicker: UIPickerView!
    
    var selStock:Stock!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        stockPicker.delegate = self
        stockPicker.dataSource = self
        
        customerLabel.text = "\(customer.description) (ID: \(customer.id))"
        
        selStock = ds.stocks[0]
        
        setFieldsFor(stock: selStock)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ds.stocks.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ds.stocks[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selStock = ds.stocks[row]
        
        setFieldsFor(stock: selStock)
    }
    
    func setFieldsFor(stock: Stock) {
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
        
        let order = Order(customer: customer, stock: selStock, quantity: quantity!)
        
        customer.addOrder(order)
        
        let alert = UIAlertController(title: "Success", message: "Order ID \(order.id) created", preferredStyle: UIAlertController.Style.alert)
        
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
