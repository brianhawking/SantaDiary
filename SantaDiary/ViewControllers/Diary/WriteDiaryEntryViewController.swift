//
//  WriteDiaryEntryViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/20/22.
//

import UIKit

class WriteDiaryEntryViewController: UIViewController {

    
    // IBOutlets
    @IBOutlet weak var happyImageView: UIImageView!
    @IBOutlet weak var angryImageView: UIImageView!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerTextView: UITextView!
    
    
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
    var selectedImage = 0
    var images: [UIImageView] = []
    var prompts: [DiaryPrompt] = [
        DiaryPrompt(question: "How are you feeling today?", answer: ""),
        DiaryPrompt(question: "What was one thing that made you smile today?", answer: "")
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        self.title = dateFormatter.string(from: Date())
        
        answerTextView.backgroundColor = .white

        leftBarButton.image = .none
    }
    
    func setupPrompts() {
        
        // adjust answer text view
        // view adjustments
        answerTextView.textContainerInset = UIEdgeInsets(top: 10, left: 20, bottom: 50, right: 20)
        answerTextView.layer.cornerRadius = 10
        answerTextView.text = prompts[0].answer
//        answerTextView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        // adjust question view
        questionLabel.text = prompts[0].question
        questionLabel.layer.cornerRadius = 10
        questionLabel.clipsToBounds = true
//        questionLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
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
            
            rightBarButton.title = "Save"
            rightBarButton.image = .none
            leftBarButton.image = UIImage(systemName: "arrowshape.turn.up.left.fill")
            
            answerTextView.text = prompts[1].answer
            
        }
        else {
            // save diary entry
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
