//
//  ContactCell.swift
//  contact-book
//
//  Created by admin on 16.01.22.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet var label: UILabel!
    @IBOutlet var starButton: UIButton!
    
    var starClickedDelegate: (() -> Void)?
    
    var isStarred = false {
        didSet {
            if (isStarred) {
                starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }
            else {
                starButton.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func handleStarButtonClick() {
        isStarred = !isStarred
        starClickedDelegate?()
    }
}
