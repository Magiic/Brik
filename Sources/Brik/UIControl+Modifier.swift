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
    func setEnabled(_ enabled: Bool) -> Self {
        self.isEnabled = enabled
        return self
    }

    @discardableResult
    func setEnabled(_ enabled: Bool, alpha: CGFloat) -> Self {
        self.isEnabled = enabled
        self.alpha = alpha
        return self
    }
}
