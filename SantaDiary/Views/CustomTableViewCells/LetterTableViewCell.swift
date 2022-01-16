//
//  LetterTableViewCell.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/5/22.
//

import UIKit

class LetterTableViewCell: UITableViewCell {
    
    static let identifier = "LetterTableViewCell"
    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var letterImageView: UIImageView!
    
    @IBOutlet weak var letterDateLabel: UILabel!
    
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var letterContentLabel: UILabel!
    
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
