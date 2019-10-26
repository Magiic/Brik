//
//  UIControl+Modifier.swift
//  MVVCArch
//
//  Created by Haithem Ben Harzallah on 24/10/2019.
//  Copyright © 2019 Haithem Ben Harzallah. All rights reserved.
//

import UIKit

//
//  UIControl+Modifier.swift
//  Brik
//
//  Created by Haithem Ben Harzallah on 24/10/2019.
//  Copyright © 2019 Haithem Ben Harzallah. All rights reserved.
//

public extension UIControl {

    @discardableResult
    func isEnabled(_ enabled: Bool) -> Self {
        self.isEnabled = enabled
        return self
    }

    @discardableResult
    func isEnabled(_ enabled: Bool, alpha: CGFloat) -> Self {
        self.isEnabled = enabled
        self.alpha = alpha
        return self
    }

    @discardableResult
    func isSelected(_ isSelected: Bool) -> Self {
        self.isSelected = isSelected
        return self
    }

    @discardableResult
    func isSelected(_ isSelected: Bool, alpha: CGFloat) -> Self {
        self.isSelected = isSelected
        self.alpha = alpha
        return self
    }

    @discardableResult
    func isHighlighted(_ isHighlighted: Bool) -> Self {
        self.isHighlighted = isHighlighted
        return self
    }

    @discardableResult
    func isHighlighted(_ isHighlighted: Bool, alpha: CGFloat) -> Self {
        self.isHighlighted = isHighlighted
        self.alpha = alpha
        return self
    }
}
