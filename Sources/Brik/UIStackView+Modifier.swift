//
//  UIStackView+Modifier.swift
//  Brik
//
//  Created by Haithem Ben Harzallah on 24/10/2019.
//  Copyright © 2019 Haithem Ben Harzallah. All rights reserved.
//

import UIKit

public extension UIStackView {

    @discardableResult
    func addArrangedSubviews(_ subviews: UIView...) -> Self {
        subviews.forEach({
            self.addArrangedSubview($0)
        })
        return self
    }
}
