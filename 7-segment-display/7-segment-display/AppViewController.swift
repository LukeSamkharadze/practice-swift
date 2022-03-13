//
//  ViewController.swift
//  7-segment-display
//
//  Created by admin on 16.10.21.
//

import UIKit

class AppViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var segmentDigitViews: [SegmentDigitView]!
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var textFieldDelegate: UITextFieldDelegate!
    
    let tetFieldMaxLength = 3
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSegmentDigits()
    }
    
    func updateSegmentDigits(paddedNumber: String = "000") {
        for (index, element) in segmentDigitViews.enumerated() {
            element.digit = paddedNumber[index].wholeNumberValue!
        }
    }
    
    @IBAction func textFieldValueChanged(sender: UITextField) {
        if let text = sender.text, text.count > tetFieldMaxLength {
            sender.text = String(text.dropLast(text.count - tetFieldMaxLength))
            return
        }
        
        updateSegmentDigits(paddedNumber: sender.text!.paddingToLeft(upTo: tetFieldMaxLength, using: "0"))

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
