//
//  FeedbackViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/13/22.
//

import UIKit

class FeedbackViewController: UIViewController {
    
    
    // get logged in user
    let profileName = UserDefaults.standard.string(forKey: "SelectedProfile")
    
    // UI | IBOutlets
    @IBOutlet weak var happyImageView: UIImageView!
    @IBOutlet weak var angryImageView: UIImageView!
    @IBOutlet weak var feedbackTextView: UITextView!
    
    var images: [UIImageView] = []
    var selectedImage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
        setupTextView()
        setupImages()
    }
    
    func setupImages() {
        images.append(happyImageView)
        images.append(angryImageView)
        
        angryImageView.alpha = 0.25
        
        for image in images {
            image.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(changeImage))
            gesture.numberOfTouchesRequired = 1
            image.addGestureRecognizer(gesture)
        }
    }

    func setupView() {
        navigationController?.navigationBar.prefersLargeTitles  = true
        navigationController!.navigationBar.tintColor           = ColorScheme.textColorOnBackground
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Noteworthy Bold", size: 32) ?? UIFont.systemFont(ofSize: 32)
        ]
        
        view.backgroundColor                                    = ColorScheme.backgroundColor
        
        self.title = "Feedback for \(profileName!)"
    }

    func setupTextView() {
        
        
        // view adjustments
        feedbackTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 50, right: 20)
        feedbackTextView.backgroundColor = UIColor.white
        
        feedbackTextView.layer.cornerRadius = 10
        feedbackTextView.layer.borderWidth = 1
        feedbackTextView.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - SELECTORS
    @objc func changeImage() {
        
        print("DEBUG: \(selectedImage)")

        selectedImage = (selectedImage+1)%2
        
        for image in images {
            image.alpha = 0.25
        }
        images[selectedImage].alpha = 1
    }
    
}
