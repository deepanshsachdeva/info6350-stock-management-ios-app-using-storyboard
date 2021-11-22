//
//  OrderDetailViewController.swift
//  assignment8
//
//  Created by Deepansh Sachdeva on 11/16/21.
//

import UIKit

class OrderDetailViewController: UIViewController {
    var order:OrderCD!
    
    let ds = DataStore.shared

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var stockPriceLabel: UILabel!
    @IBOutlet weak var buyPriceLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var buyValueLabel: UILabel!
    @IBOutlet weak var earningLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let stock = order.stock!
        
        idLabel.text = "ID: \(order.oid)"
        stockLabel.text = "Stock ID: \(stock.oid) & Name: \(stock.name!)"
        stockPriceLabel.text = "$\(stock.lastTradePrice)"
        buyPriceLabel.text = "$\(order.buyPrice)"
        datePicker.date = order.buyDate!
        
        quantityLabel.text = "\(order.quantity)"
        
        currentValueLabel.text = "$\(ds.getOrderCurrentValue(order: order))"
        buyValueLabel.text = "$\(order.buyAmount)"
        
        earningLabel.text = "Earnings = $ \(ds.getOrderCurrentValue(order: order) - order.buyAmount)"
    }
    
    @IBAction func doAction(_ sender: Any) {
        order.buyDate = datePicker.date
        
        ds.saveContext()
        
        let alert = UIAlertController(title: "Success", message: "order updated", preferredStyle: UIAlertController.Style.alert)
        
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
