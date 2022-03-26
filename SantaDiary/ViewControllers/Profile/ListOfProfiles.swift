//
//  ViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 12/23/21.
//

import UIKit
import SCLAlertView

class ListOfProfiles: UIViewController {
    
    var profiles: ProfileListViewModel = ProfileListViewModel()
    
    @IBOutlet weak var addButton: AddButton!
    
    @IBOutlet weak var removePasswordButton: UIBarButtonItem!
    
    // IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTitle()
        setupTableView()
        
        removePasswordButton.title = ""
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
//        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//
        if !parentalPasswordSet() {
            performSegue(withIdentifier: App.Segue.setParentalPasswordSegue, sender: nil)
        }
        
    }
    
    @IBAction func removeParental(_ sender: Any) {
        
        if parentalPasswordSet() {
            UserDefaults.standard.removeObject(forKey: "parentalPassword")
        }
        
        performSegue(withIdentifier: App.Segue.setParentalPasswordSegue, sender: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateTableData()
        
    }
    
    func updateTableData() {
        profiles.reloadProfiles()
        tableView.reloadData()
    }
    
    
    @IBAction func removeAll(_ sender: Any) {
        for profile in profiles.items {
            if !ProfileManager.shared.deleteProfile(profile: profile) {
                print("DEBUG: problem deleting \(profile)")
            }
        }
        
        updateTableData()
        
    }
    
    func parentalPasswordSet() -> Bool {
        if UserDefaults.standard.string(forKey: "parentalPassword") != nil {
    
            let password = UserDefaults.standard.string(forKey: "parentalPassword")!
            print("DEBUG: password is \(password)")
            return true
        }
        else {
            print("DEBUG: password not set")
            return false
        }
    }
    
    func setupTitle() {
        titleLabel.text         = App.appTitle
        titleLabel.textColor    = ColorScheme.textColorOnBackground
    
    }
    
    func setupView() {
        navigationController?.navigationBar.prefersLargeTitles  = true
        navigationController!.navigationBar.tintColor           = ColorScheme.textColorOnBackground
        view.backgroundColor                                    = ColorScheme.backgroundColor
    }
    
    func setupTableView() {
        
        // make sure this is .clear!!
        tableView.backgroundColor = .clear

        // connect to tableview cell
        let nib = UINib(nibName: ListOfProfilesCell.identifer, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ListOfProfilesCell.identifer)
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    @IBAction func addProfileButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: App.Segue.ListToAddProfile, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == App.Segue.ListToProfile {
//            let vc = segue.destination as! ProfileViewController
        }
        
        if segue.identifier == App.Segue.ListToAddProfile {
            let vc = segue.destination as! AddProfileViewController
            vc.completionHandler = {_ in
                self.profiles.reloadProfiles()
                self.tableView.reloadData()
                print("DEBUG: reloading table")
            }
        }
        
    }
}

extension ListOfProfiles: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.numberOfProfiles
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListOfProfilesCell.identifer, for: indexPath) as! ListOfProfilesCell
        
        cell.selectionStyle = .none
        
        // get profile
        let profile = profiles.getProfileViewModel(at: indexPath)
        
        // if custom image, change corner radius
        if profile.customImage {
            cell.profileImage.layer.cornerRadius = cell.profileImage.frame.height/2
            cell.profileImage.layer.borderWidth = 2
            cell.profileImage.layer.borderColor = UIColor.black.cgColor
            cell.profileImage.contentMode = .scaleToFill
        }
        
        print("\(profile.name) - \(profile.notificationForElf)")
        
        cell.backgroundColor = .clear
        cell.name.text = profile.name
        cell.profileImage.image = profile.image
        cell.age.text = profile.age
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let profile = profiles.getProfileViewModel(at: indexPath)
        
        UserDefaults.standard.set(profile.name, forKey: "SelectedProfile")
        
        performSegue(withIdentifier: App.Segue.ListToProfile, sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let appearance = SCLAlertView.SCLAppearance(
                kTitleFont: UIFont(name: "Noteworthy Bold", size: 32)!,
                kTextFont: UIFont.systemFont(ofSize: 26),
                kButtonFont: UIFont(name: "Noteworthy Bold", size: 20)!,
                showCloseButton: false,
                dynamicAnimatorActive: true,
                buttonsLayout: .horizontal
            )
            
            let alert = SCLAlertView(appearance: appearance)
            alert.addButton("YES") {
                self.tableView.beginUpdates()
                self.profiles.deleteProfileViewModel(at: indexPath)
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

