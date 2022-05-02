//
//  AddProfileViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 12/27/21.
//

import UIKit
import SCLAlertView

enum ProfileEditType {
    case create
    case edit
}

class AddProfileViewController: UIViewController, UINavigationControllerDelegate {
    
    // profile name, if editing profile
    var profileName = UserDefaults.standard.string(forKey: "SelectedProfile")

    
    // IBOutlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileDetailsView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    @IBOutlet weak var reindeerImageView: UIImageView!
    
    var completionHandler: ((Bool) -> Void)?
    var customImage = false
    
    var editingType: ProfileEditType = .create
    
    var reindeerPosition = 2
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupImages()
        setupProfileImageView()
    }
    
    // MARK: - Setup Screen
    
    func setupProfileImageView() {
        profileImageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(changeProfilePicture))
        gesture.numberOfTouchesRequired = 1
        profileImageView.addGestureRecognizer(gesture)
        
    }
    
    func setupImages() {
       
        let gesture = UITapGestureRecognizer(target: self, action: #selector(rotateReindeer(tapGestureRecognizer:)))
        reindeerImageView.addGestureRecognizer(gesture)
        reindeerImageView.isUserInteractionEnabled = true
    }
    
    func hideReindeer() {
        switch reindeerPosition {
        case 1:
            // move left
            self.reindeerImageView.frame.origin.x = -180
        case 2:
            // move down
            self.reindeerImageView.frame.origin.y = self.view.frame.height + 180
        default:
            // move right
            self.reindeerImageView.frame.origin.x = self.view.frame.width + 180
        }
    }
    
    func repositionReindeer() {
        
        self.reindeerImageView.transform = CGAffineTransform(rotationAngle: 0)
        
        reindeerPosition = Int.random(in: 1...3)
        
        let width = self.view.frame.width - 180
        let height = self.view.frame.height - 180
        
        let randomX = Double.random(in: 0...width)
        let randomY = Double.random(in: height/3...height)
        
        switch reindeerPosition {
        case 1:
            // on left
            self.reindeerImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
            self.reindeerImageView.frame.origin.x = -180
            self.reindeerImageView.frame.origin.y = randomY
        case 2:
            // bottom
            self.reindeerImageView.frame.origin.x = randomX
            self.reindeerImageView.frame.origin.y = self.view.frame.height
        default:
            // on right
            reindeerImageView.transform = CGAffineTransform(rotationAngle: -1*CGFloat.pi/2)
            self.reindeerImageView.frame.origin.x = self.view.frame.width
            self.reindeerImageView.frame.origin.y = randomY
        }
    }
    
    @objc func rotateReindeer(tapGestureRecognizer: UITapGestureRecognizer) {
        UIImageView.animate(withDuration: 0.5, delay: 0.1, options: [.curveEaseIn], animations: {
            self.hideReindeer()
            
        }, completion: { _ in
        
            self.repositionReindeer()
            
            switch self.reindeerPosition {
            case 1:
                UIImageView.animate(withDuration: 0.5, delay: 1, animations: {
                    self.reindeerImageView.frame.origin.x = -10
                })
            case 2:
                UIImageView.animate(withDuration: 0.5, delay: 1, animations: {
                    self.reindeerImageView.frame.origin.y = self.view.frame.height - 170
                })
            default:
                UIImageView.animate(withDuration: 0.5, delay: 1, animations: {
                    self.reindeerImageView.frame.origin.x = self.view.frame.width - 170
                })
            }
        })
    }
    
    func setupView() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController!.navigationBar.tintColor = ColorScheme.textColorOnBackground
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Noteworthy Bold", size: 42) ?? UIFont.systemFont(ofSize: 40)
        ]
        
        if editingType == .create {
            self.title = "Create Profile"
        }
        else {
            self.title = "Edit Profile"
            let profile = ProfileViewModel(profile: ProfileManager.shared.getProfile(name: profileName!))
            
            print("DEBUG: BEFORE: ", profile.customImage)
            
            // if custom image, change corner radius
            if profile.customImage {
                profileImageView.layer.cornerRadius = profileImageView.frame.height/2
                profileImageView.layer.borderWidth = 2
                profileImageView.layer.borderColor = UIColor.black.cgColor
                profileImageView.contentMode = .scaleToFill
            }
            
            
            profileImageView.image = profile.image
            nameTextField.text = profile.name
            birthdayPicker.date = profile.date
        }
        
        view.backgroundColor = ColorScheme.backgroundColor
        
        profileDetailsView.layer.cornerRadius = 10
    }
    
    // MARK: - Selectors
    
    @objc func changeProfilePicture() {
        presentPhotoActionSheet()
    }
    
    // MARK: - Save and Create
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        if (nameTextField.text == "") {
            nameTextField.shake()
            return
        }
        else if profileImageView.image == UIImage(systemName: "person.fill.badge.plus") {
            profileImageView.shake()
            return
        }
        
        // create profile
        switch editingType {
        case .create:
            createProfile()
        case .edit:
            editProfile()
        }
        
    }
    
    func editProfile() {
        
        
        let oldProfile = ProfileManager.shared.getProfile(name: profileName!)
        let newProfile = Profile(userID: 0, name: nameTextField.text!, image: "profilePic.png", birthday: birthdayPicker.date, customImage: customImage)
        print("DEBUG: AFTER ", customImage)
        
        if ProfileManager.shared.editProfile(from: oldProfile, to: newProfile) {
            print("DEBUG: editing profile for \(profileName!)")
            
            ProfileManager.shared.saveProfileImage(profile: newProfile, image: profileImageView.image!)
            UserDefaults.standard.set(newProfile.name, forKey: "SelectedProfile")
            let controller = self.navigationController?.viewControllers[1]
            self.navigationController?.popToViewController(controller!, animated: true)
        }
        
        
        
    }
                 
    func createProfile() {

        let profileName = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let newProfile = Profile(userID: 0, name: profileName, image: "profilePic.png", birthday: birthdayPicker.date, customImage: customImage)
        let feedback = Feedback(name: nameTextField.text!, image: "Happy", feedback: "Please continue completing diary entries so we can figure out the types of goals for you.", goals: [
            "Do your homework without being asked.",
            "Tell someone a joke to make them laugh.",
            "Make your bed.",
            "Donate a toy or book you do not play or read anymore.",
            "Help someone with their chores for the week.",
            "Give someone you care about a big hug.",
            "Make a drawing or piece of art for someone.",
            "Fold your own clothes",
            "Introduce yourself to someone new in your class. Invite them to play with you."
        ])
        
        
        if ProfileManager.shared.createProfile(profile: newProfile, editingType: editingType) {
            
            // save image to profilePic.png
            print("DEBUG: profile saved. now save image")
            ProfileManager.shared.saveProfileImage(profile: newProfile, image: profileImageView.image!)
            
            // save a feedback template
            if !FeedbackManager.shared.createFeedback(feedback: feedback) {
                print("DEBUG: issue creating the initial feedback file")
            }
            
            // return to profiles viewcontroller
            completionHandler?(true)
            navigationController?.popViewController(animated: true)
        }
        else {
            let appearence = CustomAlert().appearanceWithDone()
            let alert = SCLAlertView(appearance: appearence)
            alert.showError("Unavailable", subTitle: "\(profileName) is already taken.")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == App.Segue.toProfileImageSegue {
            let vc = segue.destination as! SelectProfileImageCollectionViewController
            vc.completionHandler = { imageNumber in
                self.profileImageView.image = UIImage(named: App.avatars[imageNumber])
                self.profileImageView.layer.cornerRadius = 0
                self.profileImageView.layer.borderWidth = 0
                self.customImage = false
            }
        }
        
    }
    
}

extension AddProfileViewController: UIImagePickerControllerDelegate {
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Premade Avatars", style: .default, handler: { [weak self] _ in
            self?.presentAvatarViewController()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "From Photo Album", style: .default, handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))
        
        present(actionSheet, animated: true)
    }
    
    func presentAvatarViewController() {
        performSegue(withIdentifier: App.Segue.toProfileImageSegue, sender: nil)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.allowsEditing = true
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        self.profileImageView.image = selectedImage
        self.profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        self.profileImageView.contentMode = .scaleToFill
        self.profileImageView.layer.borderColor = UIColor.white.cgColor
        self.profileImageView.layer.borderWidth = 2
        self.customImage = true
        
    }
}
