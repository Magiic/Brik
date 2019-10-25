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
    func lines(_ numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }

    @discardableResult
    func setTextAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
}
