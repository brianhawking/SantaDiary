//
//  ReadDiaryEntryViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/20/22.
//

import UIKit

class ReadDiaryEntryViewController: UIViewController {

    // get current user
    var profileName = UserDefaults.standard.string(forKey: "SelectedProfile")
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var diaryEntryTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
        setupTextView()
        getDiaryEntry()
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
    
    func setupTextView() {
        // view adjustments
        diaryEntryTextView.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 50, right: 20)
        diaryEntryTextView.backgroundColor = UIColor.white
        diaryEntryTextView.layer.cornerRadius = 20
    }

    func getDiaryEntry() {
        
    }

}
