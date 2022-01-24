//
//  CustomAlert.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/22/22.
//

import Foundation
import SCLAlertView

class CustomAlert {
    
    func appearance() -> SCLAlertView.SCLAppearance {
        return SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "Noteworthy Bold", size: 32)!,
            kTextFont: UIFont.systemFont(ofSize: 26),
            kButtonFont: UIFont(name: "Noteworthy Bold", size: 20)!,
            showCloseButton: false,
            dynamicAnimatorActive: true,
            buttonsLayout: .horizontal
        )
    }
    
    func showSuccessAndPop(title: String, subTitle: String, buttonText: String, vc: UIViewController) {
        
        let alert = SCLAlertView(appearance: appearance())
        alert.addButton(buttonText) {
            vc.navigationController?.popViewController(animated: true)
        }
        alert.showSuccess(title, subTitle: subTitle)
    }
}
