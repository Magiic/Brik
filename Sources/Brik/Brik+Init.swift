//
//  Brik+Init.swift
//  Brik
//
//  Created by Haithem Ben Harzallah on 24/10/2019.
//  Copyright © 2019 Haithem Ben Harzallah. All rights reserved.
//

import UIKit

public extension VBrik {
    convenience init(
        alignment: UIStackView.Alignment = .center,
        spacing: CGFloat = 0,
        distribution: UIStackView.Distribution = .fill,
        @VBrikBuilder _ content: (Brik) -> UIView) {
        self.init(content)
        if let vStack = container as? UIStackView {
            vStack.alignment = alignment
            vStack.spacing = spacing
            vStack.distribution = distribution
        }
    }
}

public extension HBrik {
    convenience init(
        alignment: UIStackView.Alignment = .center,
        spacing: CGFloat = 0,
        distribution: UIStackView.Distribution = .fill,
        @HBrikBuilder _ content: (Brik) -> UIView) {
        self.init(content)
        if let hStack = container as? UIStackView {
            hStack.alignment = alignment
            hStack.spacing = spacing
            hStack.distribution = distribution
        }
    }
}
