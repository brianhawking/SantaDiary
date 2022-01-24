//
//  NiceListViewConttroller.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/4/22.
//

import UIKit

class NiceListViewConttroller: UIViewController {

    // get current user
    var profileName = UserDefaults.standard.string(forKey: "SelectedProfile")
    
    
    
    // UI Elements
    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var feedbackView: UIView!
    @IBOutlet weak var NiceNaughtyImage: UIImageView!
    
    // Progress Bar UI Elements
    @IBOutlet weak var kindnessProgressBar: UIProgressView!
    @IBOutlet weak var kindnessCumulative: UILabel!
    @IBOutlet weak var smileCumulative: UILabel!
    @IBOutlet weak var smileProgressBar: UIProgressView!
    @IBOutlet weak var learningProgressBar: UIProgressView!
    @IBOutlet weak var learningCumulative: UILabel!
    
    var progress = NiceListProgress(kindness: 0, learning: 0, smile: 0)
    
    
    // progress bar variables
    var smileProgress: Float = 0.25
    var kindnessProgress: Float = 0.8
    var learningProgress: Float = 0.5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
        setupFeedbackView()
        setupProgressBars()
        calculateProgress()
        
        
    }
    
    func calculateProgress() {
        
        progress = DiaryManager.shared.countQuestionsAnswered(for: profileName!)
        
        smileProgress = Float(progress.smile % 4) / 4
        learningProgress = Float(progress.learning % 4) / 4
        kindnessProgress = Float(progress.kindness % 4) / 4
        
        smileCumulative.text = " " + String(progress.smile / 4) + " "
        learningCumulative.text = " " + String(progress.learning / 4) + " "
        kindnessCumulative.text = " " + String(progress.kindness / 4) + " "
        
    }
    
    func setupProgressBars() {

        kindnessProgressBar.transform = kindnessProgressBar.transform.scaledBy(x: 1, y: 5)
        
        smileProgressBar.transform = smileProgressBar.transform.scaledBy(x: 1, y: 5)
        learningProgressBar.transform = learningProgressBar.transform.scaledBy(x: 1, y: 5)
        
        kindnessCumulative.layer.borderWidth = 1
        smileCumulative.layer.borderWidth = 1
        learningCumulative.layer.borderWidth = 1
        
        DispatchQueue.main.async {
            self.animateProgressBars()
        }
        
    }
    
    func setupFeedbackView() {
        feedbackView.layer.cornerRadius = 10
        feedbackTextView.backgroundColor = .white
    }
    
    func setupView() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController!.navigationBar.tintColor = ColorScheme.textColorOnBackground
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Noteworthy Bold", size: 40) ?? UIFont.systemFont(ofSize: 40)
        ]
        
        view.backgroundColor = ColorScheme.backgroundColor
        
    }
    
    func animateProgressBars() {
        kindnessProgressBar.progress = 0.0
//        smileProgressBar.progress = 0.0
//        learningProgressBar.progress = 0.0
        
        UIView.animate(withDuration: 3, animations: {
            
            self.kindnessProgressBar.setProgress(self.kindnessProgress, animated: true)
            self.smileProgressBar.setProgress(self.smileProgress, animated: true)
            self.learningProgressBar.setProgress(self.learningProgress, animated: true)
            
            self.kindnessCumulative.transform = CGAffineTransform(translationX:self.kindnessProgressBar.frame.width * CGFloat(self.kindnessProgress), y: 0)
            self.smileCumulative.transform = CGAffineTransform(translationX:self.smileProgressBar.frame.width * CGFloat(self.smileProgress), y: 0)
            self.learningCumulative.transform = CGAffineTransform(translationX:self.learningProgressBar.frame.width * CGFloat(self.learningProgress), y: 0)
            
        }, completion: {_ in
            print("DEBUG: done animated")
            
                
                
            
        })
        
    }
    

}
