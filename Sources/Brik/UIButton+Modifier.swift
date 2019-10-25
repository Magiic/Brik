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
    func setTitle(_ title: String) -> Self {
        self.setTitle(title, for: [])
        return self
    }

    @discardableResult
    func setColor(_ color: UIColor) -> Self {
        self.setTitleColor(color, for: [])
        return self
    }

}
