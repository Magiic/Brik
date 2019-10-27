//
//  UITextField+Modifier.swift
//  Brik
//
//  Created by Haithem Ben Harzallah on 24/10/2019.
//  Copyright © 2019 Haithem Ben Harzallah. All rights reserved.
//

import UIKit

public extension UITextField {

    @discardableResult
    func placeholder(_ placeholder: String) -> Self {
        self.placeholder = placeholder
        return self
    }

    @discardableResult
    func text(_ text: String) -> Self {
        self.text = text
        return self
    }

    @discardableResult
    func color(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }

    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    func attributedText(_ attr: NSAttributedString) -> Self {
        self.attributedText = attr
        return self
    }

    @discardableResult
    func attributedPlaceholder(_ attr: NSAttributedString) -> Self {
        self.attributedPlaceholder = attr
        return self
    }

    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }

    @discardableResult
    func borderStyle(_ borderStyle: UITextField.BorderStyle) -> Self {
        self.borderStyle = borderStyle
        return self
    }

    @discardableResult
    func rightView(_ rightView: UIView?) -> Self {
        self.rightView = rightView
        return self
    }

    @discardableResult
    func leftView(_ leftView: UIView?) -> Self {
        self.leftView = leftView
        return self
    }

    @discardableResult
    func inputView(_ inputView: UIView?) -> Self {
        self.inputView = inputView
        return self
    }

    @discardableResult
    func inputAccessoryView(_ inputAccessoryView: UIView?) -> Self {
        self.inputAccessoryView = inputAccessoryView
        return self
    }

    @discardableResult
    func clearOnBeginEditing(_ clear: Bool) -> Self {
        self.clearsOnBeginEditing = clear
        return self
    }

    @discardableResult
    func minimumFontSize(_ fontSize: CGFloat) -> Self {
        self.minimumFontSize = fontSize
        return self
    }

    @discardableResult
    func adjustsFontSizeToFitWidth(_ adjustFontSize: Bool) -> Self {
        self.adjustsFontSizeToFitWidth = adjustFontSize
        return self
    }

    @discardableResult
    func delegate(_ delegate: UITextFieldDelegate) -> Self {
        self.delegate = delegate
        return self
    }

    @discardableResult
    func isSecureTextEntry(_ isSecureTextEntry: Bool) -> Self {
        self.isSecureTextEntry = isSecureTextEntry
        return self
    }

    @discardableResult
    func textContentType(_ type: UITextContentType) -> Self {
        self.textContentType = type
        return self
    }

}
