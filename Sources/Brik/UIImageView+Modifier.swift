//
//  UIImageView+Modifier.swift
//  Brik
//
//  Created by Haithem Ben Harzallah on 24/10/2019.
//  Copyright © 2019 Haithem Ben Harzallah. All rights reserved.
//

import UIKit

public extension UIImageView {

    @discardableResult
    func image(_ image: UIImage?) -> Self {
        self.image = image
        return self
    }

    @discardableResult
    func highlightedImage(_ image: UIImage?) -> Self {
        self.highlightedImage = image
        return self
    }

    @discardableResult
    func tintColor(_ color: UIColor) -> Self {
        self.tintColor = color
        return self
    }

    /// A Boolean value that determines whether user events are ignored and removed from the event queue.
    /// - Parameter isInteractive: Specifies if is interactive.
    @discardableResult
    func isUserInteractive(_ isInteractive: Bool) -> Self {
        self.isUserInteractionEnabled = isInteractive
        return self
    }

    @discardableResult
    func contentMode(_ mode: UIView.ContentMode) -> Self {
        self.contentMode = mode
        return self
    }
}
