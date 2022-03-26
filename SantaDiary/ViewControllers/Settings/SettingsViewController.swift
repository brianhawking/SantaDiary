//
//  SettingsViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/8/22.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let settings = SettingListViewModel()
    
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
        
        if segue.identifier == App.Segue.settingsToEditProfile {
            let vc = segue.destination as? AddProfileViewController
            vc?.editingType = .edit
            vc?.completionHandler = { _ in
                print("DEBUG: completed")
            }
        }
        
    }
    

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as! SettingsTableViewCell
        
        let setting = settings.getSettingViewModel(at: indexPath)
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        // if custom image, change corner radius
        if setting.customImage {
            cell.settingImageView.layer.cornerRadius = cell.settingImageView.frame.height/2
            cell.settingImageView.layer.borderWidth = 2
            cell.settingImageView.layer.borderColor = UIColor.black.cgColor
            cell.settingImageView.contentMode = .scaleToFill
        }
        
        cell.settingImageView.image = setting.image
        cell.settingLabel.text = setting.name
        
       return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let setting = settings.getSettingViewModel(at: indexPath)
        
        performSegue(withIdentifier: setting.segue, sender: indexPath)
        
    }

}
