//
//  CategoryCRUViewController.swift
//  assignment8
//
//  Created by Deepansh Sachdeva on 11/14/21.
//

import UIKit

class CategoryCRUViewController: UIViewController {
    
    var category:Category?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var btnCreateOrUpdate: UIButton!
    @IBOutlet weak var inputName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if category == nil {
            titleLabel.text = "Create Category"
            idLabel.text = ""
            btnCreateOrUpdate.setTitle("Create", for: .normal)
        } else {
            titleLabel.text = category?.name
            idLabel.text = "ID: \(category!.id)"
            inputName.text = category?.name
            btnCreateOrUpdate.setTitle("Save", for: .normal)
        }
    }
    
    @IBAction func doAction(_ sender: UIButton) {
        let name = inputName.text!
        
        guard name != "" else {
            let alert = UIAlertController(title: "Error", message: "name is required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        var alertMessage: String!
        
        if category == nil {
            ds.categories.append(Category(name: name))
            
            alertMessage = "'\(name)' category added"
        } else {
            category?.name = name
            alertMessage = "category updated"
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
