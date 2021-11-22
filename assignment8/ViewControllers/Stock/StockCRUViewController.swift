//
//  StockCRUViewController.swift
//  assignment8
//
//  Created by Deepansh Sachdeva on 11/14/21.
//

import UIKit
import CoreData

class StockCRUViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var stock:StockCD?
    
    var managedContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext!
    
    let defaultImage:UIImage = UIImage(named: "default_stock")!
    
    let categories = DataStore.shared.getCategories()
    let companies  = DataStore.shared.getCompanies()
    
    var selImage:UIImage?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var lastTradePriceInput: UITextField!
    @IBOutlet weak var financialRatingInput: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var companyPicker: UIPickerView!
    @IBOutlet weak var btnCreateOrUpdate: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    var selCategory: CategoryCD!
    var selCompany: CompanyCD!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        companyPicker.delegate = self
        companyPicker.dataSource = self
        
        if stock != nil {
            selImage = UIImage(data: (stock?.logo)!)
            
            titleLabel.text = stock?.name
            idLabel.text = "ID: \(stock!.oid)"
            nameInput.text = stock?.name
            
            let ixCategory = categories.firstIndex(where: {$0.id == stock?.category?.id})
            categoryPicker.selectRow(ixCategory!, inComponent: 0, animated: true)
            selCategory = categories[ixCategory!]
            
            let ixCompany = companies.firstIndex(where: {$0.id == stock?.company?.id})
            companyPicker.selectRow(ixCompany!, inComponent: 0, animated: true)
            selCompany = companies[ixCompany!]
            
            lastTradePriceInput.text = String(stock!.lastTradePrice)
            financialRatingInput.text = String(stock!.financialRating)
            
            btnCreateOrUpdate.setTitle("Save", for: .normal)
        } else {
            selImage = defaultImage
            
            titleLabel.text = "Create Stock"
            idLabel.text = ""
            
            selCategory = categories[0]
            selCompany = companies[0]
            
            btnCreateOrUpdate.setTitle("Create", for: .normal)
        }
        
        imageView.image = selImage
    }
    
    func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = sourceType
        
        imagePicker.delegate = self
        
        return imagePicker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        
        selImage = image
        
        self.imageView.image = selImage
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImage(_ sender: UIButton) {
        let imagePicker = imagePicker(sourceType: .photoLibrary)
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == categoryPicker {
            return categories.count
        }
        
        return companies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoryPicker {
            selCategory = categories[row]
        } else {
            selCompany = companies[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoryPicker {
            return categories[row].name
        }
        
        return companies[row].name
    }
    
    @IBAction func doAction(_ sender: UIButton) {
        let name = nameInput.text!
        let lastTradePrice = Double(lastTradePriceInput.text!)
        let financialRating = Int(financialRatingInput.text!)
        
        guard name != "" else {
            let alert = UIAlertController(title: "Error", message: "name is required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard lastTradePrice != nil else {
            let alert = UIAlertController(title: "Error", message: "last trade price is invalid", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard financialRating != nil && financialRating! >= 1 && financialRating! <= 10 else {
            let alert = UIAlertController(title: "Error", message: "financial rating should be a number between 1-10", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        var alertMessage: String!
        
        if stock != nil {
            stock!.name = name
            stock!.category = selCategory
            stock!.company = selCompany
            stock!.lastTradePrice = lastTradePrice!
            stock!.financialRating = Int16(financialRating!)
            stock!.logo = selImage?.pngData()
            
            DataStore.shared.saveContext()
            
            alertMessage = "stock updated"
        } else {
            let newStock = StockCD(context: managedContext)
            
            newStock.name = name
            newStock.company = selCompany
            newStock.category = selCategory
            newStock.lastTradePrice = lastTradePrice!
            newStock.financialRating = Int16(financialRating!)
            newStock.logo = selImage?.pngData()
            
            DataStore.shared.addStockItem(newStock)
            
            alertMessage = "'\(name)' stock created"
        }
        
        let alert = UIAlertController(title: "Success", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        
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
