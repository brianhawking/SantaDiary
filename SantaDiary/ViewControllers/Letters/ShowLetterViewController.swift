//
//  ShowLetterViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/7/22.
//

import UIKit

class ShowLetterViewController: UIViewController {

    // from previous controller
    var letter: LetterViewModel?
    
    // get current user
    var profileName = UserDefaults.standard.string(forKey: "SelectedProfile")
    
    var completion: ((Bool) -> Void)?
    
    // IBOutlets
    @IBOutlet weak var reindeerImageView: UIImageView!
    @IBOutlet weak var recipientLabel: UILabel!
    @IBOutlet weak var letterTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        setupView()
        setupTextView()
        setupReindeer()
    }
    
    func setupReindeer() {
        reindeerImageView.transform = reindeerImageView.transform.rotated(by: .pi * -1/3)
    }
    
    func setupTextView() {
        
        if let letter = letter {
            recipientLabel.text = "     Dear \(profileName!)"
            self.title = "Letter from \(letter.author)"
            letterTextView.text = letter.content
        }
        
        // adjust recipientLabel top corners
        recipientLabel.layer.cornerRadius = 20
        recipientLabel.clipsToBounds = true
        recipientLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
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
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Noteworthy Bold", size: 32) ?? UIFont.systemFont(ofSize: 32)
        ]
        
        view.backgroundColor = ColorScheme.backgroundColor
        
    }
}
