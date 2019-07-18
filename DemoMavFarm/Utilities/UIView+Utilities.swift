//
//  UIView+Utilities.swift
//  DemoMavFarm
//
//  Created by Bryan Gula on 7/17/19.
//  Copyright © 2019 Bryan Gula. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func configureSubview<T:UIView>(_ subview:T, useConstraints:Bool = true, addView:Bool = true, block: ((T) -> Void)? = nil) -> T {
        if useConstraints {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        if addView {
            self.addSubview(subview)
        }
        block?(subview)
        return subview
    }
}
