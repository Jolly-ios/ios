//
//  ViewController.swift
//  SearchFormPractise
//
//  Created by Jolly Gupta on 9/25/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var middleNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var dOBTextField: UITextField!
    
    @IBOutlet weak var saveButton2: UIButton!
    
    var firstName = ""
    var middleName = ""
    var lastName = ""
    var dob = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func saveDataButtong(_ sender: Any) {
         firstName = firstNameTextField.text ?? ""
         middleName = middleNameTextField.text ?? ""
         lastName = lastNameTextField.text ?? ""
        
        if  (firstName == "")
            || (middleName == "")
                || (lastName == ""){
            print(" Please enter all information")
        }
        else{
            //performSegue(withIdentifier: "to2ndScreen", sender: nil)
            //let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") as! secondViewController
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") as! secondViewController
            self.present(secondVC, animated: true)
        }
            
        
    }
    
    
    @IBAction func saveDOBButton(_ sender: Any) {
        dob = dOBTextField.text ?? ""
        
        if (dob == "") {
            print(" Please enter DOB")
        }
        else {
            performSegue(withIdentifier: "to3rdScreen", sender: nil)
        }
        
    }
    
    @IBAction func goToTableView(_ sender: Any) {
        //performSegue(withIdentifier: "to5thScreen", sender: nil)
        let tableViewVC = self.storyboard?.instantiateViewController(withIdentifier: "TableViewPractiseVC") as! TableViewPractiseVC
        self.present(tableViewVC, animated: true)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to2ndScreen" {
            // The destination is a navigation controller, so we need to get the root view controller
            if let secondVC = segue.destination as? secondViewController{
                
                secondVC.firstName = firstName
                secondVC.middleName = middleName
                secondVC.lastName = lastName
                
            }
        }
        
        if segue.identifier == "to3rdScreen" {
            // The destination is a navigation controller, so we need to get the root view controller
            if let thirdVC = segue.destination as? ThirdViewController{
                thirdVC.dob = dob
            }
        }
    }
    
}

