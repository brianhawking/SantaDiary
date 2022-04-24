//
//  AddGoalViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 4/13/22.
//

import UIKit

class AddGoalViewController: UIViewController {

    // get logged in user
    let profileName = UserDefaults.standard.string(forKey: "SelectedProfile")
    
    @IBOutlet weak var textView: UITextView!
    var feedback: FeedbackViewModel?
    var goals: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTextView()
        getFeedback()
        
    }
    
    func getFeedback() {
        feedback = FeedbackViewModel(feedback: FeedbackManager.shared.getFeedback(name: profileName!))
        if let goals = feedback?.goals {
            self.goals = goals
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
        
        self.title = "Add a Goal"
    }
    
    func setupTextView() {
        // view adjustments
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        textView.backgroundColor = UIColor.white
        textView.layer.cornerRadius = 20
        
        textView.becomeFirstResponder()
    }
    
    
    @IBAction func saveButtonTaped(_ sender: Any) {
        if textView.text == "" {
            textView.shake()
            return
        }
        
        // add goal to list
        goals.insert(textView.text, at: 0)
//        goals.append(textView.text)
       
        // update feedback
        
        let updatedFeedback = Feedback(name: profileName!, image: feedback!.image, feedback: feedback!.feedback, goals: goals)
        
        if FeedbackManager.shared.updateFeedback(feedback: updatedFeedback) {
        
            navigationController?.popViewController(animated: true)
        }
        
    }
    

}
