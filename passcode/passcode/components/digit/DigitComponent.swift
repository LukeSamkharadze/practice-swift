//
//  DigitView.swift
//  passcode
//
//  Created by admin on 12.12.21.
//

import UIKit

@IBDesignable class DigitComponent: ComponentView {
    @IBOutlet var digitView: UILabel!
    @IBOutlet var charactersView: UILabel!
    
    @IBInspectable var digit: String = "?" {
        didSet {
            digitView.text = digit
        }
    }
    
    @IBInspectable var characters: String = "" {
        didSet {
            charactersView.text = characters
        }
    }
    
    override func setup() {
        isUserInteractionEnabled = true
        backgroundColor = .clear
        clipsToBounds = true
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 50
    }
}
