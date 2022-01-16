//
//  AddButton.swift
//  SantaDiary
//
//  Created by Brian Veitch on 12/27/21.
//

import Foundation
import UIKit

class AddButton: UIButton {
    
    required public init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        self.layer.borderWidth = 1
        self.backgroundColor = UIColor.red
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.setTitle("  +  ", for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 36)
        self.clipsToBounds = true
        }
}
