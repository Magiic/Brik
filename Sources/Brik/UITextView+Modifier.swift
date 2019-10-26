//
//  UITextView+Modifier.swift
//  Brik
//
//  Created by Haithem Ben Harzallah on 24/10/2019.
//  Copyright © 2019 Haithem Ben Harzallah. All rights reserved.
//

import UIKit

public extension UITextView {

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
    func isEditable(_ isEditable: Bool, alpha: CGFloat = 1.0) -> Self {
        self.isEditable = isEditable
        self.alpha = alpha
        return self
    }

    @discardableResult
    func isSelectable(_ isSelectable: Bool, alpha: CGFloat = 1.0) -> Self {
        self.isSelectable = isSelectable
        self.alpha = alpha
        return self
    }

    @discardableResult
    func dataDetectorTypes(_ types: UIDataDetectorTypes) -> Self {
        self.dataDetectorTypes = types
        return self
    }

    @discardableResult
    func setAttributedText(_ attr: NSAttributedString) -> Self {
        self.attributedText = attr
        return self
    }

    @discardableResult
    func setLinkAttributes(_ attr: [NSAttributedString.Key : Any]) -> Self {
        self.linkTextAttributes = attr
        return self
    }

    @discardableResult
    func textContainerInset(_ insets: UIEdgeInsets) -> Self {
        self.textContainerInset = insets
        return self
    }

    @discardableResult
    func setInputView(_ inputView: UIView?) -> Self {
        self.inputView = inputView
        return self
    }

    @discardableResult
    func setInputAccessoryView(_ inputAccessoryView: UIView?) -> Self {
        self.inputAccessoryView = inputAccessoryView
        return self
    }

    @discardableResult
    func delegate(_ delegate: UITextViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
}
