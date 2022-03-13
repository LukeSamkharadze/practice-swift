//
//  StringExtention.swift
//  7-segment-display
//
//  Created by admin on 17.10.21.
//

import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
    
    func paddingToLeft(upTo length: Int, using element: Element = " ") -> String {
        return String(repeatElement(element, count: Swift.max(0, length-count))) + String(suffix(Swift.max(count, count-length)))
    }
}
