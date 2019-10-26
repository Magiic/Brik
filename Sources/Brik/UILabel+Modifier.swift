//
//  UILabel+Modifier.swift
//  Brik
//
//  Created by Haithem Ben Harzallah on 23/10/2019.
//  Copyright © 2019 Haithem Ben Harzallah. All rights reserved.
//

import UIKit

public extension UILabel {

    @discardableResult
    func setText(_ text: String) -> Self {
        self.text = text
        return self
    }

    @discardableResult
    func setColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }

    @discardableResult
    func setTintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }

    @discardableResult
    func lines(_ numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }

    @discardableResult
    func setTextAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }

    @discardableResult
    func setFont(_ font: UIFont) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    func isEnabled(_ isEnabled: Bool, alpha: CGFloat = 1.0) -> Self {
        self.isEnabled = isEnabled
        self.alpha = alpha
        return self
    }

    @discardableResult
    func setAttributedText(_ attr: NSAttributedString) -> Self {
        self.attributedText = attr
        return self
    }

    @discardableResult
    func setAdjustsFontSizeToFitWidth(_ adjustFontSize: Bool) -> Self {
        self.adjustsFontSizeToFitWidth = adjustFontSize
        return self
    }
}
