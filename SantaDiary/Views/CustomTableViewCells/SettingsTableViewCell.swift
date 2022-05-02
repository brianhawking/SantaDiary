//
//  SettingsTableViewCell.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/9/22.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    static let identifier = "SettingsTableViewCell"
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var settingImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        settingLabel.numberOfLines = 0
        cellView.layer.cornerRadius = 10
        cellView.layer.borderColor = UIColor.black.cgColor
        cellView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
