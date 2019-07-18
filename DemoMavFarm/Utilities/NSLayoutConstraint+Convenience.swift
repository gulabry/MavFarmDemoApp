//
//  NSLayoutConstraint+Convenience.swift
//  DemoMavFarm
//
//  Created by Bryan Gula on 7/17/19.
//  Copyright © 2019 Bryan Gula. All rights reserved.
//

import UIKit

// This extension is a convenience to add chaining to common NSLayoutConstraint operations, in particular, ones that you can't set during initialization that would require an assignment and multiple lines to set.
extension NSLayoutConstraint
{
    @discardableResult
    func prioritize(_ priority: UILayoutPriority) -> NSLayoutConstraint
    {
        self.priority = priority
        return self
    }
    
    @discardableResult
    func activate(_ activate: Bool = true) -> NSLayoutConstraint
    {
        self.isActive = activate
        return self
    }
}
