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
    func setPlaceholder(_ placeholder: String) -> Self {
        self.placeholder = placeholder
        return self
    }

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
    func setFont(_ font: UIFont) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    func setAttributedText(_ attr: NSAttributedString) -> Self {
        self.attributedText = attr
        return self
    }

    @discardableResult
    func setAttributedPlaceholder(_ attr: NSAttributedString) -> Self {
        self.attributedPlaceholder = attr
        return self
    }

    @discardableResult
    func setTextAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }

    @discardableResult
    func borderStyle(_ borderStyle: UITextField.BorderStyle) -> Self {
        self.borderStyle = borderStyle
        return self
    }

    @discardableResult
    func setRightView(_ rightView: UIView?) -> Self {
        self.rightView = rightView
        return self
    }

    @discardableResult
    func setLeftView(_ leftView: UIView?) -> Self {
        self.leftView = leftView
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
    func setClearOnBeginEditing(_ clear: Bool) -> Self {
        self.clearsOnBeginEditing = clear
        return self
    }

    @discardableResult
    func setMinimumFontSize(_ fontSize: CGFloat) -> Self {
        self.minimumFontSize = fontSize
        return self
    }

    @discardableResult
    func setAdjustsFontSizeToFitWidth(_ adjustFontSize: Bool) -> Self {
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
