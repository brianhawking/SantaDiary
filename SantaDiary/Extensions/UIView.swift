//
//  UIView.swift
//  SantaDiary
//
//  Created by Brian Veitch on 1/13/22.
//

import Foundation
import UIKit

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
 
    func rotate(end: Double) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2 + .pi * (end))
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = 0
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}
