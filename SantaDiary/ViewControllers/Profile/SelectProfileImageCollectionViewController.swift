//
//  SelectProfileImageCollectionViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/3/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class SelectProfileImageCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let padding: CGFloat = 10
    let numberOfColumns: CGFloat = 2
    var imageSize: CGFloat = 0
    var selectedRow = -1
    
    var completionHandler: ((Int) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    
        imageSize = collectionView.bounds.size.width/numberOfColumns - padding

        // Register cell classes
        collectionView!.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.identifier)

        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        navigationController?.navigationBar.prefersLargeTitles  = true
        navigationController!.navigationBar.tintColor           = ColorScheme.textColorOnBackground
        view.backgroundColor                                    = ColorScheme.backgroundColor
    }

    // MARK: - IBOutlet Actions
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        print("DEBUG: \(App.avatars[selectedRow])")
        if selectedRow != -1 {
            completionHandler?(selectedRow)
            navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return App.avatars.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.identifier, for: indexPath) as! ProfileImageCollectionViewCell
 
        cell.imageView.image = UIImage(named: App.avatars[indexPath.row])
        
        if selectedRow == indexPath.row {
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 2
        }
        else {
            cell.layer.borderWidth = 0
        }
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlow
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: imageSize, height: imageSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("DEBUG: \(App.avatars[indexPath.row])")
        if selectedRow == indexPath.row {
            selectedRow = -1
        } else {
            selectedRow = indexPath.row
        }
        collectionView.reloadData()
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
