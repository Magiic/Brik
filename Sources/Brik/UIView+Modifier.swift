//
//  UIView+Modifiers.swift
//  Brik
//
//  Created by Haithem Ben Harzallah on 21/10/2019.
//  Copyright © 2019 Haithem Ben Harzallah. All rights reserved.
//

import UIKit

public extension UIView {

    @discardableResult
    func tag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }

    @discardableResult
    func hidden(_ hidden: Bool) -> Self {
        self.isHidden = hidden
        return self
    }

    @discardableResult
    func backgroundColor(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }

    @discardableResult
    func accessibilityIdentifier(_ identifier: String? = nil) -> Self {
        if let id = identifier {
            self.accessibilityIdentifier = id
        } else {
            self.accessibilityIdentifier = String(describing: type(of: self))
        }

        return self
    }
}
