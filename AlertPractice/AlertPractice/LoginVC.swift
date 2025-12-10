//
//  LoginVC.swift
//  AlertPractice
//
//  Created by Ahmad Rafiq on 14/10/2025.
//

import UIKit

protocol LoginVCDelegate : AnyObject {
    func didLogin(success: Bool)
}

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    weak var delegate : LoginVCDelegate? = nil
    var email = "jolly@jolly.com"
    var password = "jolly"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let userEmail = emailField.text ?? ""
        let userPassword = passwordField.text ?? ""
        
        if userEmail.isEmpty || userPassword.isEmpty {
            let alertVC = UIAlertController(title: "Empty info", message: "please provide email and password", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertVC, animated: true, completion: nil)
        }
        
        if userEmail == email && userPassword == password {
            self.dismiss(animated: true) {
                self.delegate?.didLogin(success: true)
            }
        } else {
            let alertVC = UIAlertController(title: "Login failed", message: "please check email and password", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
                guard let self else { return }
                self.dismiss(animated: true) {
                    self.delegate?.didLogin(success: false)
                }
            }))
            present(alertVC, animated: true, completion: nil)
        }
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
