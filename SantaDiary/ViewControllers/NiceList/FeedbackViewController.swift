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
    @IBOutlet weak var tableView: UITableView!
    
    var images: [UIImageView] = []
    var selectedImage = 0
    var selectedGoal = -1
    
    var feedback: FeedbackViewModel?
    var goals: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
        getFeedback()
//        setupTextView()
        setupImages()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTableData()
    }
    
    func updateTableData() {
        getFeedback()
        tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
          
        // connect to tableview cell
        let nib = UINib(nibName: SettingsTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        
        tableView.estimatedRowHeight = 110
        tableView.rowHeight = UITableView.automaticDimension
        
        
        tableView.backgroundColor = .clear
        
    }
    
    func getFeedback() {
        feedback = FeedbackViewModel(feedback: FeedbackManager.shared.getFeedback(name: profileName!))
        if let goals = feedback?.goals {
            self.goals = goals
        }
    }
    
    func setupImages() {
        images.append(happyImageView)
        images.append(angryImageView)
        
        let g1 = UITapGestureRecognizer(target: self, action: #selector(changeToHappy))
        happyImageView.addGestureRecognizer(g1)
        
        let g2 = UITapGestureRecognizer(target: self, action: #selector(changeToAngry))
        angryImageView.addGestureRecognizer(g2)
        
        for image in images {
            image.alpha = 0.25
            image.isUserInteractionEnabled = true
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
        
        self.title = "Nice or Naughty"
    }

//    func setupTextView() {
//
//
//        // view adjustments
//        feedbackTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 50, right: 20)
//        feedbackTextView.backgroundColor = UIColor.white
//        feedbackTextView.textColor = UIColor.black
//
//        feedbackTextView.layer.cornerRadius = 10
//        feedbackTextView.layer.borderWidth = 1
//        feedbackTextView.layer.borderColor = UIColor.black.cgColor
//
//        if let feedback = feedback {
//            feedbackTextView.text = feedback.feedback
//        }
//    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if selectedGoal == -1 {
            tableView.shake()
            return
        }
        
        // update feedback
        let updatedFeedback = Feedback(name: profileName!, image: App.emojis[selectedImage], feedback: goals[selectedGoal], goals: goals)
        
        if FeedbackManager.shared.updateFeedback(feedback: updatedFeedback) {
            
            CustomAlert().showSuccessAndPop(title: "Congrats!", subTitle: "You set a new goal for \(profileName!)", buttonText: "OK", vc: self)
            navigationController?.popViewController(animated: true)
        }
        
//        if feedbackTextView.text == "" {
//            feedbackTextView.shake()
//            CustomAlert().incompleteForm(title: "Error", subTitle: "Please complete the feedback area.")
//            return
////        navigationController?.popViewController(animated: true)
//        }
        
        // update feedback
//        let updatedFeedback = Feedback(name: profileName!, image: App.emojis[selectedImage], feedback: feedbackTextView.text!)
//
//        if FeedbackManager.shared.updateFeedback(feedback: updatedFeedback) {
//            CustomAlert().showSuccessAndPop(title: "Congrats!", subTitle: "You updated meaningful feedback for \(profileName!)", buttonText: "OK", vc: self)
//
//        }
        
        
    }
    
    // MARK: - SELECTORS
    
    @objc func changeToHappy() {
        if selectedImage != 0 {
            selectedImage = 0
            happyImageView.alpha = 1
            angryImageView.alpha = 0.25
        }
    }
    
    @objc func changeToAngry() {
        if selectedImage != 1 {
            selectedImage = 1
            happyImageView.alpha = 0.25
            angryImageView.alpha = 1
        }
    }
    
    @objc func changeImage() {
        
        print("DEBUG: \(selectedImage)")

        selectedImage = (selectedImage+1)%2
        
        for image in images {
            image.alpha = 0.25
        }
        images[selectedImage].alpha = 1
    }
    
}

extension FeedbackViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 110
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = feedback?.goals.count else {return 0}
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as! SettingsTableViewCell
        
        cell.backgroundColor = .clear
        
        cell.settingLabel.font = UIFont(name: "Chalkboard SE Regular", size: 20)
        
        cell.settingLabel.text = goals[indexPath.row]
        cell.settingImageView.image = UIImage(named: App.holidayImages[indexPath.row % 4])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGoal = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let appearance = SCLAlertView.SCLAppearance(
                kTitleFont: UIFont(name: "Chalkboard SE Bold", size: 24)!,
                kTextFont: UIFont(name: "Chalkboard SE Regular", size: 20)!,
                kButtonFont: UIFont(name: "Chalkboard SE Regular", size: 20)!,
                showCloseButton: false,
                dynamicAnimatorActive: true,
                buttonsLayout: .horizontal
            )
            
            let alert = SCLAlertView(appearance: appearance)
            alert.addButton("YES") {
                self.tableView.beginUpdates()
                
                self.goals.remove(at: indexPath.row)
                
                let updatedFeedback = Feedback(name: self.profileName!, image: self.feedback!.image, feedback: self.feedback!.feedback, goals: self.goals)
                
                
                if FeedbackManager.shared.updateFeedback(feedback: updatedFeedback) {
                    print("SUCCESSFUL")
                }
                
                self.feedback = FeedbackViewModel(feedback: FeedbackManager.shared.getFeedback(name: self.profileName!))
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.endUpdates()
            }
            alert.addButton("NO") {
                
            }
            alert.showWarning("Confirm...", subTitle: "Are you sure you want to delete this profile?")
            
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
}
