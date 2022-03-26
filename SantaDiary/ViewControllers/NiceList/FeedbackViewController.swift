//
//  FeedbackViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/13/22.
//

import UIKit
import SCLAlertView

class FeedbackViewController: UIViewController {
    
    
    // get logged in user
    let profileName = UserDefaults.standard.string(forKey: "SelectedProfile")
    
    // UI | IBOutlets
    @IBOutlet weak var happyImageView: UIImageView!
    @IBOutlet weak var angryImageView: UIImageView!
    @IBOutlet weak var feedbackTextView: UITextView!
    
    var images: [UIImageView] = []
    var selectedImage = 0
    
    var feedback: FeedbackViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
        getFeedback()
        setupTextView()
        setupImages()
    }
    
    func getFeedback() {
        feedback = FeedbackViewModel(feedback: FeedbackManager.shared.getFeedback(name: profileName!))
    }
    
    func setupImages() {
        images.append(happyImageView)
        images.append(angryImageView)
        
        for image in images {
            image.alpha = 0.25
            image.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(changeImage))
            gesture.numberOfTouchesRequired = 1
            image.addGestureRecognizer(gesture)
        }
        
        if let feedback = feedback {
            switch feedback.imageType {
                
            case .happy:
                happyImageView.alpha = 1
                selectedImage = 0
            case .angry:
                angryImageView.alpha = 1
                selectedImage = 1
            }
        }
    }

    func setupView() {
        navigationController?.navigationBar.prefersLargeTitles  = true
        navigationController!.navigationBar.tintColor           = ColorScheme.textColorOnBackground
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Noteworthy Bold", size: 32) ?? UIFont.systemFont(ofSize: 32)
        ]
        
        view.backgroundColor = ColorScheme.backgroundColor
        
        self.title = "Feedback for \(profileName!)"
    }

    func setupTextView() {
        
        
        // view adjustments
        feedbackTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 50, right: 20)
        feedbackTextView.backgroundColor = UIColor.white
        feedbackTextView.textColor = UIColor.black
        
        feedbackTextView.layer.cornerRadius = 10
        feedbackTextView.layer.borderWidth = 1
        feedbackTextView.layer.borderColor = UIColor.black.cgColor
        
        if let feedback = feedback {
            feedbackTextView.text = feedback.feedback
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if feedbackTextView.text == "" {
            feedbackTextView.shake()
            CustomAlert().incompleteForm(title: "Error", subTitle: "Please complete the feedback area.")
            return
//        navigationController?.popViewController(animated: true)
        }
        
        // update feedback
        let updatedFeedback = Feedback(name: profileName!, image: App.emojis[selectedImage], feedback: feedbackTextView.text!)
        
        if FeedbackManager.shared.updateFeedback(feedback: updatedFeedback) {
            CustomAlert().showSuccessAndPop(title: "Congrats!", subTitle: "You updated meaningful feedback for \(profileName!)", buttonText: "OK", vc: self)

        }
        
        
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
