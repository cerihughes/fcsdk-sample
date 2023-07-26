//
//  UIKit+Extensions.swift
//  FCSDKSample
//
//  Created by Awen CS on 26/07/2023.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
