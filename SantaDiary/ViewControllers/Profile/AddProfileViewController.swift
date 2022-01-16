//
//  AddProfileViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 12/27/21.
//

import UIKit

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
    
    var completionHandler: ((Bool) -> Void)?
    var customImage = false
    
    var editingType: ProfileEditType = .create
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupProfileImageView()
    }
    
    // MARK: - Setup Screen
    
    func setupProfileImageView() {
        profileImageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(changeProfilePicture))
        gesture.numberOfTouchesRequired = 1
        profileImageView.addGestureRecognizer(gesture)
        
    }
    
    func setupView() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController!.navigationBar.tintColor = ColorScheme.textColorOnBackground
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Noteworthy Bold", size: 42) ?? UIFont.systemFont(ofSize: 40)
        ]
        
        print("DEBUG: \(editingType)")
        if editingType == .create {
            self.title = "Create Profile"
        }
        else {
            self.title = "Edit Profile"
            let profile = ProfileViewModel(profile: ProfileManager.shared.getProfile(name: profileName!))
            profileImageView.image = profile.image
            nameTextField.text = profile.name
            birthdayPicker.date = profile.date
        }
        
        view.backgroundColor = ColorScheme.backgroundColor
    }
    
    // MARK: - Selectors
    
    @objc func changeProfilePicture() {
        print("DEBUG: change image")
        presentPhotoActionSheet()
    }
    
    // MARK: - Save and Create
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        if (nameTextField.text == "") {
            print("DEBUG: Enter a name")
            return
        }
        else if profileImageView.image == UIImage(systemName: "person.fill.badge.plus") {
            print("DEBUG: Choose a photo")
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
        
        if ProfileManager.shared.editProfile(from: oldProfile, to: newProfile) {
            print("DEBUG: editing profile for \(profileName!)")
            
            ProfileManager.shared.saveProfileImage(profile: newProfile, image: profileImageView.image!)
            UserDefaults.standard.set(newProfile.name, forKey: "SelectedProfile")
            let controller = self.navigationController?.viewControllers[1]
            self.navigationController?.popToViewController(controller!, animated: true)
        }
        
        
        
    }
                 
    func createProfile() {

        let newProfile = Profile(userID: 0, name: nameTextField.text!, image: "profilePic.png", birthday: birthdayPicker.date, customImage: customImage)
        
        if ProfileManager.shared.createProfile(profile: newProfile, editingType: editingType) {
            
            // save image to profilePic.png
            print("DEBUG: profile saved. now save image")
            ProfileManager.shared.saveProfileImage(profile: newProfile, image: profileImageView.image!)
            
            // return to profiles viewcontroller
            completionHandler?(true)
            navigationController?.popViewController(animated: true)
            
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
