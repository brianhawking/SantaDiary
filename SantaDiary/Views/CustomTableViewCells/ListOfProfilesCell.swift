//
//  ListOfProfilesCell.swift
//  SantaDiary
//
//  Created by Brian Veitch on 12/24/21.
//

import UIKit

class ListOfProfilesCell: UITableViewCell {

    static let identifer = "ListOfProfilesCell"
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellView.layer.cornerRadius = 10
        cellView.layer.borderColor = UIColor.black.cgColor
        cellView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
