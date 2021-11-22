//
//  SearchStockViewController.swift
//  assignment8
//
//  Created by Deepansh Sachdeva on 11/15/21.
//

import UIKit

class SearchStockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var stocks:[StockCD] = DataStore.shared.getStocks()
    
    var filteredStocks: [StockCD] = []
    
    @IBOutlet weak var keywordInput: UITextField!
    @IBOutlet weak var categorySelector: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.leftBarButtonItem = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = filteredStocks.count
        
        if count == 0 {
            tableView.setEmptyView(title: "No search results", message: "no stocks found according to search criteria")
            self.navigationItem.leftBarButtonItem = .none
        } else {
            tableView.restore()
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SearchStockResultsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchStockResultsTableViewCell
        
        cell.textLabel?.text = "\(filteredStocks[indexPath.row].name!)"
        
        cell.imageView?.image = UIImage(data: filteredStocks[indexPath.row].logo!)
                
        return cell
    }
    
    @IBAction func doAction(_ sender: UIButton) {
        let keyword = keywordInput.text!
        
        guard keyword != "" else {
            let alert = UIAlertController(title: "Error", message: "enter keyword to search", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        switch categorySelector.selectedSegmentIndex {
        case 0:
            filteredStocks = stocks.filter({ $0.name?.lowercased().contains(keyword.lowercased()) as! Bool })
        case 1:
            filteredStocks = stocks.filter({ $0.company?.name?.lowercased().contains(keyword.lowercased()) as! Bool })
        case 2:
            filteredStocks = stocks.filter({ $0.category?.name?.lowercased().contains(keyword.lowercased()) as! Bool })
        case 3:
            print("3")
            let searchTerm = Int(keyword)
            
            guard searchTerm != nil else {
                let alert = UIAlertController(title: "Error", message: "financial rating should be number from 1 to 10", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            filteredStocks = stocks.filter({ Int($0.financialRating) == searchTerm })
            
        case 4:
            print("4")
            let searchTerm = Double(keyword)
            
            guard searchTerm != nil else {
                let alert = UIAlertController(title: "Error", message: "last trade price should be decimal", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            filteredStocks = stocks.filter({ $0.lastTradePrice == searchTerm })
        default:
            return
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let row = self.tableView.indexPathForSelectedRow?.row
        let vdc = segue.destination as? StockCRUViewController
        vdc?.stock = filteredStocks[row ?? 0]
    }

}
