//
//  OrderMainTableViewController.swift
//  assignment8
//
//  Created by Deepansh Sachdeva on 11/15/21.
//

import UIKit

class OrderMainTableViewController: UITableViewController {
    
    var customer:CustomerCD!
    
    var orders:[OrderCD] = []
    
    let ds = DataStore.shared

    @IBOutlet weak var customerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //  self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        customerLabel.text = "for \(customer.firstName!+" "+customer.lastName!) (ID: \(customer.oid))"
        
        refreshData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = orders.count
        
        if count == 0 {
            tableView.setEmptyView(title: "You don't have any order.", message: "Your orders will be in here.")
            self.navigationItem.leftBarButtonItem = .none
        } else {
            tableView.restore()
        }
        
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let order = orders[indexPath.row]
        
        cell.textLabel?.text = "ID: \(order.oid) Stock: \((order.stock?.name)!)"
        cell.detailTextLabel?.text = "Quantity: \(order.quantity) Current Value: $\(ds.getOrderCurrentValue(order: order))"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        if !ds.isOrderSold(order: orders[indexPath.row]) {
            let action = UIContextualAction(style: .normal, title: "Sell", handler: {(action, view, completionHandler) in
                
                self.ds.sellOrder(order: self.orders[indexPath.row])
                self.refreshData()

                let alert = UIAlertController(title: "Success", message: "sell success", preferredStyle: UIAlertController.Style.alert)

                let successAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {_ in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(successAction)

                self.present(alert, animated: true, completion: nil)

                completionHandler(true)
            })

            action.backgroundColor = .systemGreen

            return UISwipeActionsConfiguration(actions: [action])
        }

        return nil
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            ds.removeOrderItem(orders[indexPath.row])
            refreshData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if ds.isOrderSold(order: orders[indexPath.row]) {
            return UITableViewCell.EditingStyle.none
        }
        
        return UITableViewCell.EditingStyle.delete
    }
    
    func refreshData() {
        orders = ds.getOrdersForCustomer(customer: customer)
        tableView.reloadData()
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "orderdetails" {
            let row = self.tableView.indexPathForSelectedRow?.row
            
            if let vdc = segue.destination as? OrderDetailViewController {
                 vdc.order = orders[row ?? 0]
            }
        } else {
            if let vdc = segue.destination as? OrderCreateViewController {
                vdc.customer = customer
            }
        }
    }

}
