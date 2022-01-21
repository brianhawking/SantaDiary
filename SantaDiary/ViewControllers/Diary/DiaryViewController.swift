//
//  DiaryViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/4/22.
//

import UIKit

class DiaryViewController: UIViewController {

    // get current user
    var profileName = UserDefaults.standard.string(forKey: "SelectedProfile")

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
        setupTableView()
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
    
    func setupTableView() {
        
        tableView.backgroundColor = .clear
        
        // connect to tableview cell
        let nib = UINib(nibName: LetterTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: LetterTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: App.Segue.diaryToWriteEntry, sender: nil)
    }
}

extension DiaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LetterTableViewCell.identifier, for: indexPath) as! LetterTableViewCell
        
        // adjust cell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        cell.letterDateLabel.text = "HI"
        cell.letterContentLabel.text = "this is content"
        cell.letterImageView.image = UIImage(named: "Happy")
        
        return cell
    }
    
    
    
    
}
