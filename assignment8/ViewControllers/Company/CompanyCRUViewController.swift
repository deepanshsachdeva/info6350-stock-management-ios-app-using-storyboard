//
//  CompanyCRUViewController.swift
//  assignment8
//
//  Created by Deepansh Sachdeva on 11/14/21.
//

import UIKit

class CompanyCRUViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var company: Company?
    
    let defaultImage:UIImage = UIImage(named: "default_company.png")!
    
    var selImage:UIImage?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var symbolInput: UITextField!
    @IBOutlet weak var btnCreateOrUpdate: UIButton!
    @IBOutlet weak var headquarterInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if company != nil {
            selImage = company?.logo
            
            titleLabel.text = company?.name
            idLabel.text = "ID: \(company!.id)"
            nameInput.text = company?.name
            symbolInput.text = company?.symbol
            headquarterInput.text = company?.headquarter
            emailInput.text = company?.email
            
            btnCreateOrUpdate.setTitle("Save", for: .normal)
        } else {
            selImage = defaultImage
            
            titleLabel.text = "Create Company"
            idLabel.text = ""
            
            btnCreateOrUpdate.setTitle("Create", for: .normal)
        }
        
        imageView.image = selImage
    }
    
    @IBAction func selectImage(_ sender: UIButton) {
        let imagePicker = imagePicker(sourceType: .photoLibrary)
        
        self.present(imagePicker, animated: true, completion: nil)
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
    
    @IBAction func doAction(_ sender: UIButton) {
        let name = nameInput.text!
        let symbol = symbolInput.text!
        let headquarter = headquarterInput.text!
        let email = emailInput.text!
        
        guard name != "" else {
            let alert = UIAlertController(title: "Error", message: "name is required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard symbol != "" else {
            let alert = UIAlertController(title: "Error", message: "symbol is required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard headquarter != "" else {
            let alert = UIAlertController(title: "Error", message: "headquarter is required", preferredStyle: UIAlertController.Style.alert)
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
        
        if company != nil {
            company?.name = name
            company?.symbol = symbol
            company?.headquarter = headquarter
            company?.email = email
            company?.logo = selImage!
            
            alertMessage = "company updated"
        } else {
            ds.companies.append(Company(name: name, symbol: symbol, headquarter: headquarter, email: email))
            alertMessage = "'\(name)' company added"
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
