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
        
        setupView()
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
        hiddenTextField.resignFirstResponder()
        let appearence = CustomAlert().appearance()
        let alert = SCLAlertView(appearance: appearence)
        
//
//        let password = alert.addTextField("Confirm your password")
        alert.addButton("Confirm") { [self] in
            UserDefaults.standard.set(self.hiddenTextField.text!, forKey: "parentalPassword")
                self.navigationController?.popViewController(animated: true)
        }
        alert.addButton("Retry") { [self] in
            hiddenTextField.becomeFirstResponder()
        }
        alert.showSuccess("Password set!", subTitle: "Your password is \(self.hiddenTextField.text!). You can reset it by pressing the hidden button on the top right of the list of profiles page.")
    
    }
    
    func showAlert() {
        let appearence = CustomAlert().appearance()
        let alert = SCLAlertView(appearance: appearence)
        alert.addButton("I understand") { [self] in
            
            hiddenTextField.becomeFirstResponder()
        }
        alert.showNotice("Password", subTitle: "Create your parental password. Make sure you check out the parent's section (settings icon in child's profile) after creating the child's profile to understand your role in this app.")
//        hiddenTextField.becomeFirstResponder()
    }

    func setupHiddenTextField() {
        hiddenTextField.delegate = self
//        hiddenTextField.becomeFirstResponder()
        hiddenTextField.isHidden = true
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
            NSAttributedString.Key.font: UIFont(name: "Noteworthy Bold", size: 32) ?? UIFont.systemFont(ofSize: 32)
        ]
        
        view.backgroundColor = ColorScheme.backgroundColor
        
        self.title = "Set up parental passcode"
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if Int(textField.text!) == nil {
//            return
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
            
            if (digit == 3) {
                saveButtonTapped((Any).self)
            }
            
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
