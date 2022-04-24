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
            kTitleFont: UIFont(name: "Chalkboard SE Regular", size: 24)!,
            kTextFont: UIFont(name: "Chalkboard SE Regular", size: 20)!,
            kButtonFont: UIFont(name: "Chalkboard SE Regular", size: 20)!,
            showCloseButton: false,
            dynamicAnimatorActive: true,
            buttonsLayout: .horizontal
        )
    }
    
    func appearanceWithDone() -> SCLAlertView.SCLAppearance {
        return SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "Chalkboard SE Regular", size: 24)!,
            kTextFont: UIFont(name: "Chalkboard SE Regular", size: 20)!,
            kButtonFont: UIFont(name: "Chalkboard SE Regular", size: 20)!,
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
    
    func incompleteForm(title: String, subTitle: String) {
        let alert = SCLAlertView(appearance: appearance())
        alert.showError(title, subTitle: subTitle)
    }
}
