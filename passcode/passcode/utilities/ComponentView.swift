//
//  ComponentView.swift
//  passcode
//
//  Created by admin on 14.12.21.
//

import UIKit

class ComponentView: UIView {
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadView()
        setup()
    }
    
    func setup() { }
    
    func loadView() {
        let bundle = Bundle(for: Self.self)
        let className = String(describing: Self.self)
        bundle.loadNibNamed(className, owner: self, options: nil)
        
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(contentView)
    }
}
