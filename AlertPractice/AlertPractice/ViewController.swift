//
//  ViewController.swift
//  AlertPractice
//
//  Created by Ahmad Rafiq on 12/10/2025.
//

import UIKit

class ViewController: UIViewController, LoginVCDelegate {

    @IBOutlet weak var loginDescLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    func didLogin(success: Bool) {
        if success {
            loginDescLabel.text = "You have successfully login, now you can see forecast of upto 20 days...!"
            loginButton.isHidden = true
        } else {
            loginDescLabel.text = "Want to see weather forecast for upto 20 days?"
            loginButton.isHidden = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    @IBAction func loginButtonWasPressed(_ sender: Any) {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        loginVC.delegate = self
        self.present(loginVC, animated: true)
    }
    
    @IBAction func todayWeatherCastTapped(_ sender: Any) {
        let todayWeatherCastVC = self.storyboard?.instantiateViewController(withIdentifier: "TodayWeatherCastVC") as! TodayWeatherCastVC
        self.present(todayWeatherCastVC, animated: true)
        
    }
    
    @IBAction func show(_ sender: Any) {
        let vc = UIAlertController(title: "test", message: "adfd", preferredStyle: .actionSheet)
        vc.addAction(UIAlertAction(title: "adfa", style: .default))
        vc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // For iPad support, configure the popover presentation
        if let popoverController = vc.popoverPresentationController {
            if let button = sender as? UIButton {
                popoverController.sourceView = button
                popoverController.sourceRect = button.bounds
            } else {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
        }
        
        present(vc, animated: true)
    }
    
}

