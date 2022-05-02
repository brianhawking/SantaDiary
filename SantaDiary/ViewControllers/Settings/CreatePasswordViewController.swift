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
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet var digits: [UILabel]!

    var task = "parentalBirthyear"
    var reset = false
    
    var digit = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        setupView()
        showForgetPasswordNotice()
        setupHiddenTextField()
        setupBoxes()
    }
    
   
    @IBAction func saveButtonTapped(_ sender: Any) {
    
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
        
        
        alert.addButton("Confirm") { [self] in
            UserDefaults.standard.set(self.hiddenTextField.text!, forKey: task)
            
            if task == "parentalPassword" {
                self.navigationController?.popViewController(animated: true)
            } else {
                if reset == false {
                    task = "parentalPassword"
                    showAlert()
                    self.title = "Enter your password."
                }
                
            }
            
            print(UserDefaults.standard.string(forKey: "parentalPassword"))
        }
        alert.addButton("Retry") { [self] in
            resetPassword()
            hiddenTextField.becomeFirstResponder()
        }
        
        var message = "Your birth year is \(self.hiddenTextField.text!). Use this to reset your password in the future."
        if task == "parentalPassword" {
            message = "Your password is \(self.hiddenTextField.text!). You can reset it in the parental section of the app."
        }
        alert.showSuccess("Password set!", subTitle: message)
    
    }
    
    func resetPassword() {
        
        for digit in digits {
            digit.text = ""
        }
        digit = 0
        hiddenTextField.text = ""
        print("reset password")
    }
    
    func showAlert() {
        let appearence = CustomAlert().appearance()
        let alert = SCLAlertView(appearance: appearence)
        alert.addButton("I understand") { [self] in
            
            hiddenTextField.becomeFirstResponder()
            resetPassword()
        }
    
        alert.showNotice("Password", subTitle: "Create your parental password. Make sure you check out the parent's section (settings icon in child's profile) after creating the child's profile to understand your role in this app.")
    }
    
    func showForgetPasswordNotice() {
        
        let appearence = CustomAlert().appearance()
        let alert = SCLAlertView(appearance: appearence)
        alert.addButton("I understand") { [self] in
            hiddenTextField.becomeFirstResponder()
        }
        
        if reset == false {
            alert.showNotice("Forget your password?", subTitle: "Enter your birth year now. Use this if you ever need to reset your password.")
        }
        else {
            alert.showNotice("Forget your password?", subTitle: "Enter your birth year now.")
        }
        
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
        
        self.title = "Enter your birth year"
        
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
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
            
            if (digit == 3) {
                
                if reset == true && self.hiddenTextField.text! == UserDefaults.standard.string(forKey: "parentalBirthyear") {
                    task = "parentalPassword"
                    showAlert()
                    self.title = "Set new password."
                    reset = false
                } else if reset == true && self.hiddenTextField.text! != UserDefaults.standard.string(forKey: "parentalBirthyear") {
                    
                    for digit in digits {
                        digit.shake()
                    }
                    resetPassword()
                    return
                } else {
                    saveButtonTapped((Any).self)
                }
            }
            
            if (digit < 3) {
                digit += 1
            }
        }
        else if digit != characterCount {
            
            // remove digit from box
            digits[digit-1].text = " "
            
            if (digit > 0) {
                digit -= 1
            }
        }
        
        
    }
    
}
