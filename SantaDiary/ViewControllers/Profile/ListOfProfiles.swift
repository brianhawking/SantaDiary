//
//  ViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 12/23/21.
//

import UIKit

class ListOfProfiles: UIViewController {
    
    var profiles: ProfileListViewModel = ProfileListViewModel()
    
    @IBOutlet weak var addButton: AddButton!
    
    // IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTitle()
        setupTableView()
        
        if !parentalPasswordSet() {
            performSegue(withIdentifier: App.Segue.setParentalPasswordSegue, sender: nil)
        }
        
    }
    
    @IBAction func removeParental(_ sender: Any) {
        
        if UserDefaults.standard.string(forKey: "parentalPassword") != nil {
            UserDefaults.standard.removeObject(forKey: "parentalPassword")
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        profiles.reloadProfiles()
        tableView.reloadData()
    }
    
    func parentalPasswordSet() -> Bool {
        if UserDefaults.standard.string(forKey: "parentalPassword") != nil {
            return true
        }
        else {
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
        
        tableView.backgroundColor = .clear
        
        // connect to tableview cell
        let nib = UINib(nibName: ListOfProfilesCell.identifer, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ListOfProfilesCell.identifer)
        
        tableView.delegate = self
        tableView.dataSource = self
    }


    @IBAction func buttonTapped(_ sender: Any) {
        performSegue(withIdentifier: App.Segue.ListToProfile, sender: nil)
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
    
    
    
}
