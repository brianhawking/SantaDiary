//
//  ParentsLettersViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/10/22.
//

import UIKit

class ParentsLettersViewController: UIViewController {
    
    // get user's name
    let profileName = UserDefaults.standard.string(forKey: "SelectedProfile")
    
    // get the tableview data
    let settings = ParentsListViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
        setupTableView()
    }
    
    func setupView() {
        navigationController?.navigationBar.prefersLargeTitles  = true
        navigationController!.navigationBar.tintColor           = ColorScheme.textColorOnBackground
        view.backgroundColor                                    = ColorScheme.backgroundColor
    }
    
    func setupTableView() {
        
        tableView.backgroundColor = .clear
        
        // connect to tableview cell
        let nib = UINib(nibName: SettingsTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = sender as? IndexPath
        let setting = settings.getSettingViewModel(at: indexPath!)
        
        if segue.identifier == App.Segue.parentsToWriteLetter {
            
            let vc = segue.destination as! WriteLetterViewController
            
            switch setting.imageString {
            case "fromSanta":
                vc.authorType = .santa
            case "fromElf":
                vc.authorType = .elf
            default:
                vc.authorType = .user
            }
            
        }
        
    }
}

extension ParentsLettersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as! SettingsTableViewCell
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        let setting = settings.getSettingViewModel(at: indexPath)
        
        cell.settingLabel.text = setting.name
        cell.settingImageView.image = setting.image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let setting = settings.getSettingViewModel(at: indexPath)
        
        if setting.segue == App.Segue.parentsToProfile {
            let controller = self.navigationController?.viewControllers[1]
            self.navigationController?.popToViewController(controller!, animated: true)
        }
        else {
            performSegue(withIdentifier: setting.segue, sender: indexPath)
        }
        
        
        
    }
    
    
    
    
}