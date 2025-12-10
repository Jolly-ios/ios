//
//  ThirdViewController.swift
//  SearchFormPractise
//
//  Created by Jolly Gupta on 9/25/25.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var dOBLabel: UILabel!
    
    var dob = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dOBLabel.text = dob

        // Do any additional setup after loading the view.
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
