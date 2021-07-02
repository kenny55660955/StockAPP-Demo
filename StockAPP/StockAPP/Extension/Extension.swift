//
//  Extension.swift
//  StockAPP
//
//  Created by Kenny on 2021/7/3.
//

import Foundation
import UIKit

// MARK: - Frame extension
extension UIView {
    var width: CGFloat {
        frame.size.width
    }
    
    var height: CGFloat {
        frame.size.height
    }
    
    var left: CGFloat {
        frame.origin.x
    }
    var right: CGFloat {
        left + width
    }
    var top: CGFloat {
        frame.origin.y
    }
    var bottom: CGFloat {
        top + height
    }
}
