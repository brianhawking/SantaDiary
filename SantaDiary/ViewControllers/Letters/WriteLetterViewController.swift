//
//  LetterToSantaViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/4/22.
//

import UIKit
import SCLAlertView

class WriteLetterViewController: UIViewController {
    
    // get current user
    var profileName = UserDefaults.standard.string(forKey: "SelectedProfile")

    var authorType: Author = .user
    var author = ""
    var recipient = ""
    var canSave = true
    
    // IBOutlets
    @IBOutlet weak var letterTextView: UITextView!
    @IBOutlet weak var reindeerImageView: UIImageView!
    @IBOutlet weak var envelopeImageView: UIImageView!
    
    @IBOutlet weak var snowmanImageView: UIImageView!
    @IBOutlet weak var recipientLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
        setupTextView()
        setupImages()
    
    }
    
    func setupImages() {
        reindeerImageView.transform = reindeerImageView.transform.rotated(by: .pi * -1/3)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(rotateReindeer(tapGestureRecognizer:)))
        reindeerImageView.addGestureRecognizer(gesture)
        reindeerImageView.isUserInteractionEnabled = true
        
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(rotateSnowman(tapGestureRecognizer:)))
        snowmanImageView.addGestureRecognizer(gesture1)
        snowmanImageView.isUserInteractionEnabled = true
    }
    
    @objc func rotateReindeer(tapGestureRecognizer: UITapGestureRecognizer) {
        print("rotate me")
        reindeerImageView.rotate(end: -1/3)
    }
    @objc func rotateSnowman(tapGestureRecognizer: UITapGestureRecognizer) {
        print("rotate me")
        snowmanImageView.rotate(end: 0)
    }
    
    func setupTextView() {
        
        // determine the author and recipeint of the letter
        switch authorType {
            
            case .user:
                author = profileName!
                recipient = "Santa"
            case .santa:
                author = "Santa"
                recipient = profileName!
            case .elf:
                author = App.elves.randomElement()!
                recipient = profileName!
        }
        
        self.title = "Letter to \(recipient)"
        
        
        // adjust recipient label
        recipientLabel.text = "   Dear \(recipient),"
        recipientLabel.layer.cornerRadius = 20
        recipientLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        recipientLabel.clipsToBounds = true
        
        
        // view adjustments
        letterTextView.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 50, right: 20)
        letterTextView.backgroundColor = UIColor.white
        letterTextView.layer.cornerRadius = 20
        letterTextView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
    }
    
    func setupView() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController!.navigationBar.tintColor = ColorScheme.textColorOnBackground
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.clear,
            NSAttributedString.Key.font: UIFont(name: "Noteworthy Bold", size: 40) ?? UIFont.systemFont(ofSize: 40)
        ]
        
        view.backgroundColor = ColorScheme.backgroundColor
        
    }
    
    func animateSendingLetter() {
        UIView.animate(withDuration: 0.25, animations: {
            print("DEBUG: animating")
            self.letterTextView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.letterTextView.alpha = 0
            self.recipientLabel.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.recipientLabel.alpha = 0
            
            self.snowmanImageView.transform = CGAffineTransform(translationX: 0, y: -500)
            self.reindeerImageView.transform = CGAffineTransform(translationX: 150, y: 0)
            
            
        }, completion: {_ in
            
            UIView.animate(withDuration: 1.5, delay: 1.5, animations: {
                self.envelopeImageView.transform = CGAffineTransform(translationX: self.view.frame.width+50, y: -300)
                
            }, completion: {_ in
                
                self.navigationController?.popViewController(animated: true)
            })
        })
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        if !canSave {
            return
        }
        
        if (letterTextView.text == "") {
            letterTextView.shake()
            SCLAlertView().showWarning("Blank", subTitle: "Don't forget to write your letter.")
            return
        }
        
        let letter = Letter(
            author: author,
            recipient: recipient,
            content: letterTextView.text,
            authorType: authorType)
        
        if LetterManager.shared.createLetter(letter: letter) {
            print("DEBUG: letter created")
            // disable save button
            canSave = false
            animateSendingLetter()
        }
        
    }
    

    
}
