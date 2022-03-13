//
//  ViewController.swift
//  passcode
//
//  Created by admin on 11.12.21.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var dotsComponent: DotsComponent!
    @IBOutlet var digitComponents: [DigitComponent]!
    
    func passwordEntered() {
        performSegue(withIdentifier: "gotoHome", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dotsComponent.passwordEnteredListeners.append(passwordEntered)
        
        digitComponents.forEach {
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(digitClicked)))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dotsComponent.level=0
    }
    
    @objc func digitClicked() {
        dotsComponent.level+=1
    }
    
    @IBAction func deleteClicked() {
        dotsComponent.level-=1
    }
}
