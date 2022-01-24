//
//  WriteDiaryEntryViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/20/22.
//

import UIKit
import SCLAlertView

class WriteDiaryEntryViewController: UIViewController {

    // get current user
    var profileName = UserDefaults.standard.string(forKey: "SelectedProfile")
    
    var readOrWrite = ReadOrWrite.write
    
    // IBOutlets
    @IBOutlet weak var happyImageView: UIImageView!
    @IBOutlet weak var angryImageView: UIImageView!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerTextView: UITextView!
    
    
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
 
    var selectedImage = App.emojis[0]
    var imageIndex = 0
    var images: [UIImageView] = []
    var prompts: [DiaryPrompt] = [
        DiaryPrompt(type: .initial),
        DiaryPrompt(type: .random)
    ]
    var currentQuestion = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
        setupPrompts()
        setupImages()
        
    }
    
    func setupView() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.tintColor = ColorScheme.textColorOnBackground
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Noteworthy Bold", size: 32) ?? UIFont.systemFont(ofSize: 32)
        ]
        
        view.backgroundColor = ColorScheme.backgroundColor
        
        answerTextView.backgroundColor = .white

        leftBarButton.image = .none
    }
    
    func setupPrompts() {
        
     
        if readOrWrite == .read {
            // disable textview
            answerTextView.isEditable = false
        }
        
        // adjust answer text view
        // view adjustments
        answerTextView.textContainerInset = UIEdgeInsets(top: 10, left: 20, bottom: 50, right: 20)
        answerTextView.layer.cornerRadius = 10
        answerTextView.text = prompts[0].answer
        
        // adjust question view
        questionLabel.text = prompts[0].question
        questionLabel.layer.cornerRadius = 10
        questionLabel.clipsToBounds = true
        
    }

    func setupImages() {
        
        happyImageView.image = UIImage(named: App.emojis[0])
        angryImageView.image = UIImage(named: App.emojis[1])
        
        images.append(happyImageView)
        images.append(angryImageView)
        
        angryImageView.alpha = 0.25
        
        for image in images {
            
            if readOrWrite == .read && image.image != UIImage(named: selectedImage) {
                image.isHidden = true
            }
            else if readOrWrite == .read && image.image == UIImage(named: selectedImage) {
                image.alpha = 1
            }
            else {
                
                image.isUserInteractionEnabled = true
                let gesture = UITapGestureRecognizer(target: self, action: #selector(changeImage))
                gesture.numberOfTouchesRequired = 1
                image.addGestureRecognizer(gesture)
            }
            
            
        }
    }
    
    @IBAction func prevButtonTapped(_ sender: Any) {
        
        if currentQuestion == 1 {
            // save answer
            prompts[1].answer = answerTextView.text
            
            answerTextView.text = prompts[0].answer
            questionLabel.text = prompts[0].question
            
            leftBarButton.image = .none
            rightBarButton.title = ""
            rightBarButton.image = UIImage(systemName: "arrowshape.turn.up.right.fill")
            
            currentQuestion -= 1
        }
        
        
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        if answerTextView.text == "" {
            answerTextView.shake()
            return
        }
            
        // save current answer to prompts
        prompts[currentQuestion].answer = answerTextView.text
        
        // move to next question
        if currentQuestion == 0 {
            
            currentQuestion += 1
            
            // show question 2
            questionLabel.text = prompts[currentQuestion].question
            answerTextView.text = prompts[currentQuestion].answer
            
            if readOrWrite != .read {rightBarButton.title = "Save"}
            rightBarButton.image = .none
            leftBarButton.image = UIImage(systemName: "arrowshape.turn.up.left.fill")
            
            answerTextView.text = prompts[1].answer
            
        }
        else {
            if readOrWrite != .read {
                // save diary entry
                saveDiaryEntry()
            }
            
        }
    }
    
    func saveDiaryEntry() {
        
        let diaryEntry = DiaryEntry(
            author: profileName!,
            image: App.emojis[imageIndex],
            prompts: prompts)
        
        if DiaryManager.shared.createDiaryEntry(entry: diaryEntry) {
            // tell user everything is OK
            CustomAlert().showSuccessAndPop(title: "Success", subTitle: "You created a new diary entry.", buttonText: "OK", vc: self)
        }
        else {
            SCLAlertView().showError("Error!", subTitle: "Something went wrong")
        }
    }
    
    // MARK: - SELECTORS
    @objc func changeImage() {
        
        print("DEBUG: \(imageIndex)")

        imageIndex = (imageIndex+1)%2
        
        for image in images {
            image.alpha = 0.25
        }
        images[imageIndex].alpha = 1
    }

    
}
