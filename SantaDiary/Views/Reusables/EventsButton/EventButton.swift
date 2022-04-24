//
//  EventButton.swift
//  SantaDiary
//
//  Created by Brian Veitch on 12/26/21.
//

import UIKit

class EventButton: UIView {

    @IBOutlet var parentView: UIView!
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventLabel: UILabel!
    var type: EventType?
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
        
    func commonInit() {
        let viewFromXIB = Bundle.main.loadNibNamed("EventButton", owner: self, options: nil)![0] as! UIView
        viewFromXIB.frame = self.bounds
        self.addSubview(viewFromXIB)
        applyView()
    }
    
    func boxSize() -> CGFloat {
        return min(UIScreen.main.bounds.width * 0.4, UIScreen.main.bounds.height/4)
    }
    
    func applyView() {
        self.backgroundColor = .clear
        parentView.backgroundColor = ColorScheme.eventButtonBackgroundColor
        parentView.layer.cornerRadius = 10
        parentView.layer.borderColor = UIColor.black.cgColor
        parentView.layer.borderWidth = 1
        parentView.clipsToBounds = true
        parentView.isUserInteractionEnabled = true
    }
    
    func applyGoldView() {
        parentView.layer.borderColor = UIColor.yellow.cgColor
        parentView.layer.borderWidth = 5
        parentView.layer.shadowColor = UIColor.yellow.cgColor
        parentView.layer.shadowOpacity = 0.5
        parentView.layer.shadowOffset = .zero
        parentView.layer.shadowRadius = 5
        parentView.layer.cornerRadius = 10
    }
    
    enum EventType: String {
        case niceList = "Nice List"
        case writeLetter = "Send Letter"
        case readLetter = "Mailbox"
        case diary = "Diary"
    }

    func update(with type: EventType) {
        
        eventLabel.text = type.rawValue
        self.type = type
        
        switch type {
        case .niceList:
            eventImage.image = UIImage(named: "Presents")
        case .writeLetter:
            eventImage.image = UIImage(named: "fromSanta")
        case .readLetter:
            eventImage.image = UIImage(named: "Mailbox")
        case .diary:
            eventImage.image = UIImage(named: "Diary")
        }
    }

}
