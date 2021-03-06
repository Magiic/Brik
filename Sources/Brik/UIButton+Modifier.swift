//
//  UIButton+Modifier.swift
//  Brik
//
//  Created by Haithem Ben Harzallah on 23/10/2019.
//  Copyright © 2019 Haithem Ben Harzallah. All rights reserved.
//

import UIKit

public extension UIButton {

    @discardableResult
    func title(_ title: String) -> Self {
        self.setTitle(title, for: [])
        return self
    }

    @discardableResult
    func color(_ color: UIColor) -> Self {
        self.setTitleColor(color, for: [])
        return self
    }

    @discardableResult
    func tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }

    @discardableResult
    func image(_ image: UIImage?, state: UIControl.State = []) -> Self {
        self.setImage(image, for: state)
        return self
    }

    @discardableResult
    func backgroundImage(_ image: UIImage?, state: UIControl.State = []) -> Self {
        self.setBackgroundImage(image, for: state)
        return self
    }

    @discardableResult
    func contentEdgeInsets(_ insets: UIEdgeInsets) -> Self {
        self.contentEdgeInsets = insets
        return self
    }

    @discardableResult
    func titleEdgeInsets(_ insets: UIEdgeInsets) -> Self {
        self.titleEdgeInsets = insets
        return self
    }

    @discardableResult
    func imageEdgeInsets(_ insets: UIEdgeInsets) -> Self {
        self.imageEdgeInsets = insets
        return self
    }

    @discardableResult
    func attributedTitle(_ attr: NSAttributedString?, state: UIControl.State = []) -> Self {
        self.setAttributedTitle(attr, for: state)
        return self
    }

}
