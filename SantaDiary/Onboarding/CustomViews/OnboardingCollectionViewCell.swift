//
//  OnboardingCollectionViewCell.swift
//  SantaDiary
//
//  Created by Brian Veitch on 3/26/22.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var slideDescriptionLabel: UILabel!
    
    @IBOutlet weak var slideDescriptionTextView: UITextView!
    
    func setup(slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLabel.text = slide.title
        slideTitleLabel.font = UIFont(name: "Noteworthy Bold", size: 36)
//        slideDescriptionLabel.text = slide.description
        slideDescriptionTextView.text = slide.description
    }
    
    
}
