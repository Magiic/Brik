//
//  UIView+Modifiers.swift
//  Brik
//
//  Created by Haithem Ben Harzallah on 21/10/2019.
//  Copyright © 2019 Haithem Ben Harzallah. All rights reserved.
//

import UIKit

public extension UIView {

    subscript<C>(class: C.Type) -> C? where C: UIView {
        self as? C
    }

    @discardableResult
    func setTag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }

    @discardableResult
    func setHidden(_ hidden: Bool) -> Self {
        self.isHidden = hidden
        return self
    }

    @discardableResult
    func backgroundColor(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
}
