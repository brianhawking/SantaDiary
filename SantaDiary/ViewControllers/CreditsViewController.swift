//
//  CreditsViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 3/19/22.
//

import UIKit

class CreditsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
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
    

}
