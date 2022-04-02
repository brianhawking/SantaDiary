//
//  ProfileViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 12/23/21.
//

import UIKit

class ProfileViewController: UIViewController {
 
    var profileName = UserDefaults.standard.string(forKey: "SelectedProfile")
    
    var profile: ProfileViewModel?
    
    // IBOutlets
    @IBOutlet weak var event1: EventButton!
    @IBOutlet weak var event2: EventButton!
    @IBOutlet weak var event3: EventButton!
    @IBOutlet weak var event4: EventButton!
    
    @IBOutlet var eventButtonCollection: [EventButton]!

    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupProfile()
        setupView()
        setupButtons()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        profileName = UserDefaults.standard.string(forKey: "SelectedProfile")
        setupProfile()
        setupButtons()
    }
    
    func setupProfile() {
        
        guard let profileName = profileName else {
            return
        }
        
        // get profile
        profile = ProfileViewModel(profile: ProfileManager.shared.getProfile(name: profileName))
        
        guard let profile = profile else {
            return
        }
        
        // display profile name
        self.title = profile.name
        
        // profile image
        profileImageView.image = profile.image
        
        // if custom image, add the corner radius and border
        if profile.customImage {
            profileImageView.layer.cornerRadius = profileImageView.bounds.height/2
            profileImageView.layer.borderWidth = 2
            profileImageView.layer.borderColor = ColorScheme.eventButtonBackgroundColor?.cgColor
            profileImageView.contentMode = .scaleToFill
        }
        
    }
    
    func setupView() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController!.navigationBar.tintColor = ColorScheme.textColorOnBackground
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Noteworthy Bold", size: 50) ?? UIFont.systemFont(ofSize: 40)
        ]
        
        view.backgroundColor = ColorScheme.backgroundColor
    }

    func setupButtons() {
        
        eventButtonCollection.append(event2)
        eventButtonCollection.append(event3)
        eventButtonCollection.append(event4)
        
        for event in eventButtonCollection {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(setupSegue))
            gesture.numberOfTouchesRequired = 1
            event.addGestureRecognizer(gesture)
            
            if LetterManager.shared.getLetters(for: profileName!, type: .unread).count != 0 && event == event4 {
                event.layer.borderColor = UIColor.yellow.cgColor
                event.layer.borderWidth = 5
                event.layer.shadowColor = UIColor.yellow.cgColor
                event.layer.shadowOpacity = 0.5
                event.layer.shadowOffset = .zero
                event.layer.shadowRadius = 5
                event.layer.cornerRadius = 10
            }

        }
        
        event1.update(with: .niceList)
        event2.update(with: .writeLetter)
        event3.update(with: .diary)
        event4.update(with: .readLetter)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == App.Segue.profileToWriteLetterSegue {
            let vc = segue.destination as! WriteLetterViewController
            vc.authorType = .user
        }
    }
    
    
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: App.Segue.profileToSettingsSegue, sender: nil)
    }
    
    // MARK: - Selectors
    
    @objc func setupSegue(sender: UITapGestureRecognizer) {
        
        print("DEBUG: event button pressed")
        
        let tag = sender.view!.tag
        
        switch tag {
        case 1:
            performSegue(withIdentifier: App.Segue.profileToNiceListSegue, sender: nil)
        case 2:
            performSegue(withIdentifier: App.Segue.profileToWriteLetterSegue, sender: nil)
        case 3:
            performSegue(withIdentifier: App.Segue.profileToDiarySegue, sender: nil)
        case 4:
            performSegue(withIdentifier: App.Segue.profileToMailboxSegue, sender: nil)
        
        default:
            print("DEBUG: not sure what happened. segue failed")
        }
    }
}
