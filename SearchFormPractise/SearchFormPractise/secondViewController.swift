//
//  secondViewController.swift
//  SearchFormPractise
//
//  Created by Jolly Gupta on 9/25/25.
//

import UIKit

class secondViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var middleNameLabel: UILabel!
    
    var firstName = ""
    var middleName = ""
    var lastName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameLabel.text = firstName
        middleNameLabel.text = middleName
        lastNameLabel.text = lastName
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
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
