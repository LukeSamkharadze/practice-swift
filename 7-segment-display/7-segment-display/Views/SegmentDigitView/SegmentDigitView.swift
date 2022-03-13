//
//  SegmentDigitView.swift
//  7-segment-display
//
//  Created by admin on 17.10.21.
//

import UIKit

@IBDesignable
class SegmentDigitView: UIView {
    
    static let digitToSegments = [
        0: [],
        1: [1,2],
        2: [0,1,6,4,3],
        3: [0,1,6,2,3],
        4: [1,2,6,5],
        5: [0,5,6,2,3],
        6: [0,5,6,2,3,4],
        7: [0,1,2],
        8: [0,1,2,3,4,5,6],
        9: [0,1,2,3,6,5]
    ]
    
    var segments: [UIView] = []
    
    @IBInspectable
    let segmentSize = 10
    
    public var digit = 0 {
        didSet { updateSegments() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func updateSegments() {
        segments.forEach {$0.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)}
        SegmentDigitView.digitToSegments[digit]?.forEach {segments[$0].backgroundColor = .red}
    }
    
    private func setup() {
        
        let top = UIView(frame: CGRect(x: segmentSize, y: 0, width: Int(frame.width)-segmentSize*2, height: segmentSize))
        
        let topRight = UIView(frame: CGRect(x: Int(frame.width)-segmentSize, y: segmentSize, width: segmentSize, height: Int(frame.height)/2-segmentSize*3/2))
        
        let bottomRight = UIView(frame: CGRect(x: Int(frame.width)-segmentSize, y: Int(frame.height/2)+segmentSize/2, width: segmentSize, height: Int(frame.height)/2-segmentSize*3/2))
        
        let bottom = UIView(frame: CGRect(x: segmentSize, y: Int(frame.height)-segmentSize, width: Int(frame.width)-segmentSize*2, height: segmentSize))
        
        let bottomLeft = UIView(frame: CGRect(x: 0, y: Int(frame.height/2)+segmentSize/2, width: segmentSize, height: Int(frame.height/2)-segmentSize*3/2))
        
        let topLeft = UIView(frame: CGRect(x: 0, y: segmentSize, width: segmentSize, height: Int(frame.height/2)-segmentSize*3/2))
        
        let middle = UIView(frame: CGRect(x: segmentSize, y: Int(frame.height/2)-segmentSize/2, width: Int(frame.width)-segmentSize*2, height: segmentSize))
        
        segments = [top, topRight, bottomRight, bottom, bottomLeft, topLeft, middle];
        
        segments.forEach {addSubview($0)}
    }
}

