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

    let diaryEntries = DiaryEntryListViewModel()
    var readOrWrite = ReadOrWrite.write
    var entryToSend: DiaryEntryViewModel?
    var monthYear = MonthYear()
    var filterByMonth = true
    
    @IBOutlet weak var filterStackView: UIStackView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
        setupTableView()
        updateDiary(filter: filterByMonth)
        dateLabel.text = monthYear.asString()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDiary(filter: filterByMonth)
        setupView()
    }
    
    func updateDiary(filter: Bool) {
        diaryEntries.reload(for: profileName!)
        if filter {
            diaryEntries.filter(monthYear: monthYear)
        }
        
        tableView.reloadData()
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
        readOrWrite = .write
        performSegue(withIdentifier: App.Segue.diaryToWriteEntry, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! WriteDiaryEntryViewController
        vc.readOrWrite = readOrWrite
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
//        vc.title = dateFormatter.string(from: Date())
        
        if readOrWrite == .read {
            vc.prompts = entryToSend!.prompts
            vc.selectedImage = entryToSend!.image
            vc.title = entryToSend!.formattedDate
        }
    }
    
    @IBAction func changeMonth(_ sender: UIButton) {
        
        if sender.tag == 1 {
            monthYear.back()
        }
        else {
            monthYear.forward()
        }
        
        dateLabel.text = monthYear.asString()
        updateDiary(filter: true)
        
    }
    
    
    @IBAction func filterByMonth(_ sender: Any) {
        filterByMonth = true
        updateDiary(filter: true)
        filterStackView.isHidden = false
    }
    
    
    @IBAction func viewAll(_ sender: Any) {
        filterByMonth = false
        updateDiary(filter: false)
        filterStackView.isHidden = true
    }
}

extension DiaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaryEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LetterTableViewCell.identifier, for: indexPath) as! LetterTableViewCell
        
        let diary = diaryEntries.getDiaryEntryViewModel(at: indexPath)
        
        // adjust cell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        cell.letterDateLabel.text = diary.formattedDate
        cell.letterContentLabel.text = diary.preview
        cell.letterImageView.image = UIImage(named: diary.image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        entryToSend = diaryEntries.getDiaryEntryViewModel(at: indexPath)
        
        readOrWrite = .read
        
        performSegue(withIdentifier: App.Segue.diaryToWriteEntry, sender: nil)
        
    }
    
    
    
    
}
