//
//  CustomerCRUViewController.swift
//  assignment8
//
//  Created by Deepansh Sachdeva on 11/14/21.
//

import UIKit

class CustomerCRUViewController: UIViewController {
    
    var customer:Customer?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var firstnameInput: UITextField!
    @IBOutlet weak var lastnameInput: UITextField!
    @IBOutlet weak var addressInput: UITextField!
    @IBOutlet weak var contactInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var btnCreateOrUpdate: UIButton!
    @IBOutlet weak var orderTabBtn: UIBarButtonItem!
    
    @IBOutlet weak var investedLabel: UILabel!
    @IBOutlet weak var earnedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if customer != nil {
            titleLabel.text = customer?.description
            idLabel.text = "ID: \(customer!.id)"
            
            firstnameInput.text = customer?.firstName
            lastnameInput.text = customer?.lastName
            addressInput.text = customer?.address
            contactInput.text = customer?.contact
            emailInput.text = customer?.email
            
            investedLabel.text = " Invested: $\(customer!.getTotalInvestingAmount())"
            earnedLabel.text = " Earned: $\(customer!.getTotalEarningAmount())"
            
            btnCreateOrUpdate.setTitle("Save", for: .normal)
        } else {
            titleLabel.text = "Create Customer"
            idLabel.text = ""
            
            investedLabel.text = ""
            earnedLabel.text = ""
            
            orderTabBtn.isEnabled = false
            
            btnCreateOrUpdate.setTitle("Create", for: .normal)
        }
    }
    

    @IBAction func doAction(_ sender: UIButton) {
        let firstName = firstnameInput.text!
        let lastName = lastnameInput.text!
        let address = addressInput.text!
        let contact = contactInput.text!
        let email = emailInput.text!
        
        guard firstName != "" else {
            let alert = UIAlertController(title: "Error", message: "first name is required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard lastName != "" else {
            let alert = UIAlertController(title: "Error", message: "last name is required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard address != "" else {
            let alert = UIAlertController(title: "Error", message: "address is required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard contact != "" else {
            let alert = UIAlertController(title: "Error", message: "contact is required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard contact.isValidPhoneNumber() else {
            let alert = UIAlertController(title: "Error", message: "contact is not valid", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard email != "" else {
            let alert = UIAlertController(title: "Error", message: "email is required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard email.isValidEmail() else {
            let alert = UIAlertController(title: "Error", message: "email is not valid", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        var alertMessage:String!
        
        if customer != nil {
            customer?.firstName = firstName
            customer?.lastName = lastName
            customer?.address = address
            customer?.contact = contact
            customer?.email = email
            
            alertMessage = "customer updated"
        } else {
            ds.customers.append(Customer(firstName: firstName, lastName: lastName, address: address, contact: contact, email: email))
            
            alertMessage = "'\(firstName+" "+lastName)' customer added"
        }
        
        let alert = UIAlertController(title: "Success", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        
        let successAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {_ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(successAction)
        
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let vdc = segue.destination as? OrderMainTableViewController {
            vdc.customer = customer
        }
    }

}
