//
//  MailboxViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/4/22.
//

import UIKit

class MailboxViewController: UIViewController {
    
    // get current user
    var profileName = UserDefaults.standard.string(forKey: "SelectedProfile")
    
    var letters: LetterListViewModel = LetterListViewModel()
    var letterToSend: LetterViewModel?
    var currentIndex = 0

    @IBOutlet weak var mailboxSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupSegmentedControl()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateLetters()
    }
    
    func setupSegmentedControl() {
        mailboxSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .callout), NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        
        mailboxSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)

    }
    
    func updateLetters() {
        
        switch currentIndex {
        case 0:
            letters.reload(for: profileName!, type: .unread)
        case 1:
            letters.reload(for: profileName!, type: .received)
        case 2:
            letters.reload(for: profileName!, type: .sent)
        case 3:
            letters.reload(for: profileName!, type: .showAll)
        default:
            letters.reload(for: profileName!, type: .showAll)
        }
        
        tableView.reloadData()
    }

    
    @IBAction func mailboxSegmentedControlTapped(_ sender: Any) {
        
        switch mailboxSegmentedControl.selectedSegmentIndex {
        case 0:
            letters.reload(for: profileName!, type: .unread)
        case 1:
            letters.reload(for: profileName!, type: .received)
        case 2:
            letters.reload(for: profileName!, type: .sent)
        case 3:
            letters.reload(for: profileName!, type: .showAll)
        default:
            letters.reload(for: profileName!, type: .showAll)
        }
        
        currentIndex = mailboxSegmentedControl.selectedSegmentIndex
        
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == App.Segue.mailboxToShowLetterSegue {

            guard let letter = letterToSend else { return }
        
            let vc = segue.destination as! ShowLetterViewController
            vc.letter = letter
            
        }
    }
    
}

extension MailboxViewController: UITableViewDelegate,
                                 UITableViewDataSource {
    
    func setupTableView() {
        
        letters.reload(for: profileName!, type: .unread)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .clear
        
        // connect to tableview cell
        let nib = UINib(nibName: LetterTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: LetterTableViewCell.identifier)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return letters.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LetterTableViewCell.identifier, for: indexPath) as! LetterTableViewCell
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        // get letter
        let letter = letters.getLetterViewModel(at: indexPath)
     
        cell.letterImageView.image = UIImage(named: letter.image)
        cell.letterDateLabel.text = letter.formattedDate
        cell.letterContentLabel.text = letter.content
        
        // change cell if it's an unread letter
        if letter.unread == true {
            // new letter
            cell.cellView.layer.borderColor = UIColor.yellow.cgColor
            cell.cellView.layer.borderWidth = 5
            cell.cellView.layer.shadowColor = UIColor.yellow.cgColor
            cell.cellView.layer.shadowOpacity = 0.5
            cell.cellView.layer.shadowOffset = .zero
            cell.cellView.layer.shadowRadius = 5
            
            // do not show letter content
            cell.letterContentLabel.text = "Letter from \(letter.author)"
        }
        else {
            cell.cellView.layer.borderColor = UIColor.black.cgColor
            cell.cellView.layer.borderWidth = 2
            cell.cellView.layer.shadowColor = UIColor.clear.cgColor
            cell.cellView.layer.shadowOpacity = 0.5
            cell.cellView.layer.shadowOffset = .zero
            cell.cellView.layer.shadowRadius = 0
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // get letter ready to send
        letterToSend = letters.getLetterViewModel(at: indexPath)
        
        // change letter to unread: false
        letterToSend!.updateReadStatus()
        
        updateLetters()
        
        performSegue(withIdentifier: App.Segue.mailboxToShowLetterSegue, sender: nil)
        
    }
    
    
    
    
}
