//
//  AddOrderViewController.swift
//  TestApp
//
//  Created by Ahmad Rafiq on 21/09/2025.
//

import UIKit

protocol AddOrderDelegate: AnyObject {
    func didAddOrder(_ order: Order)
}

class AddOrderViewController: UIViewController {
    
    @IBOutlet weak var orderNameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    weak var delegate: AddOrderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextFields()
    }
    
    private func setupUI() {
        title = "Add Order"
        
        // Add cancel button
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.leftBarButtonItem = cancelButton
        
        // Style the save button
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 8
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private func setupTextFields() {
        orderNameTextField.delegate = self
        priceTextField.delegate = self
        quantityTextField.delegate = self
        
        // Set keyboard types
        priceTextField.keyboardType = .decimalPad
        quantityTextField.keyboardType = .numberPad
        
        // Add toolbar to numeric keyboards
        addDoneButtonToKeyboard(textField: priceTextField)
        addDoneButtonToKeyboard(textField: quantityTextField)
    }
    
    private func addDoneButtonToKeyboard(textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        
        toolbar.items = [flexSpace, doneButton]
        textField.inputAccessoryView = toolbar
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard validateInputs() else { return }
        
        let orderName = orderNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let price = Double(priceTextField.text!)!
        let quantity = Int(quantityTextField.text!)!
        
        let newOrder = Order(name: orderName, price: price, quantity: quantity)
        OrderManager.shared.saveOrder(newOrder)
        
        delegate?.didAddOrder(newOrder)
        
        // Show success message
        showSuccessAlert {
            self.dismiss(animated: true)
        }
    }
    
    private func validateInputs() -> Bool {
        // Validate order name
        guard let orderName = orderNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !orderName.isEmpty else {
            showAlert(title: "Invalid Input", message: "Please enter an order name.")
            return false
        }
        
        // Validate price
        guard let priceText = priceTextField.text,
              let price = Double(priceText),
              price > 0 else {
            showAlert(title: "Invalid Input", message: "Please enter a valid price greater than 0.")
            return false
        }
        
        // Validate quantity
        guard let quantityText = quantityTextField.text,
              let quantity = Int(quantityText),
              quantity > 0 else {
            showAlert(title: "Invalid Input", message: "Please enter a valid quantity greater than 0.")
            return false
        }
        
        return true
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func showSuccessAlert(completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "Success", message: "Order added successfully!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion()
        })
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension AddOrderViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == orderNameTextField {
            priceTextField.becomeFirstResponder()
        } else if textField == priceTextField {
            quantityTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
