//
//  UIView + Ext.swift
//  autodocNews
//
//  Created by Alexander Abanshin on 27.10.2025.
//

import UIKit

extension UIView {
    func addView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }
}
