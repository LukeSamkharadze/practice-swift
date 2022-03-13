//
//  DotsComponent.swift
//  passcode
//
//  Created by admin on 14.12.21.
//

import UIKit

@IBDesignable class DotsComponent: ComponentView {
    var passwordEnteredListeners: [() -> Void] = []
    
    @IBOutlet var dots: [UIView]!
    
    @IBInspectable var level: Int = 0 {
        didSet {
            level = min(max(0, level), dots.count)
            
            dots.forEach {
                $0.backgroundColor = .clear
            }
            
            dots[0..<level].forEach {
                $0.backgroundColor = .systemGray
            }
            
            if (level == 4) {
                passwordEnteredListeners.forEach {
                    $0()
                }
            }
        }
    }
}
