//
//  CreatePasswordViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/13/22.
//

import UIKit
import SCLAlertView

class CreatePasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var hiddenTextField: UITextField!
    
    @IBOutlet var digits: [UILabel]!
    
    var digit = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        showAlert()
        setupHiddenTextField()
        setupBoxes()
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        print(hiddenTextField.text!)
        
        if hiddenTextField.text!.count < 4 {
            SCLAlertView().showWarning("Password", subTitle: "Password must be 4 digits long.")
            return
        }
        
        showConfirmation()
        
    }
    
    func showConfirmation() {
        let alert = SCLAlertView()
    
        
        let password = alert.addTextField("Confirm your password")
        alert.addButton("Confirm") { [self] in
            if password.text == self.hiddenTextField.text! {
                UserDefaults.standard.set(password.text!, forKey: "parentalPassword")
                self.navigationController?.popViewController(animated: true)
            }
            else {
                self.showConfirmation()
            }
        }
        alert.showEdit("Confirm", subTitle: "Confirm your password...")
    }
    
    func showAlert() {
        SCLAlertView().showNotice("Password", subTitle: "Create your parental password.")
    }

    func setupHiddenTextField() {
        hiddenTextField.delegate = self
        hiddenTextField.becomeFirstResponder()
        hiddenTextField.isHidden = true
        hiddenTextField.becomeFirstResponder()
    }
    
    func setupBoxes() {
        for box in digits {
            box.layer.borderColor = UIColor.black.cgColor
            box.layer.borderWidth = 1
            box.layer.cornerRadius = 10
            box.clipsToBounds = true
            
        }
    }
    
    func setupView() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController!.navigationBar.tintColor = ColorScheme.textColorOnBackground
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Noteworthy Bold", size: 50) ?? UIFont.systemFont(ofSize: 40)
        ]
        
        view.backgroundColor = ColorScheme.backgroundColor
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if Int(textField.text!) == nil {
            return
        }
        
        // get text count, 0 if it's null
        var characterCount = textField.text?.count ?? 0
        
        print("digit: \(digit), count \(characterCount)")
        
        // character reached it's max
        if(characterCount == 5) {
            textField.text?.removeLast()
            characterCount = textField.text!.count
        }
        
        // hasn't reached max, add digit to screen
        if (characterCount < 5 && digit+1 <= characterCount ) {
            
            // add a character
            digits[characterCount-1].text = textField.text![characterCount - 1]
//            digits[characterCount-1].text = "\u{2022}"
            
            if (digit < 3) {
                digit += 1
            }
        }
        else {
            
            // remove digit from box
            digits[digit].text = " "
            
            if (digit > 0) {
                digit -= 1
            }
        }
        
        
    }
    
}
