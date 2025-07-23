//
//  UIView +.swift
//  Millionaire
//
//  Created by Варвара Уткина on 22.07.2025.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { self.addSubview($0) }
    }
}
