//
//  File.swift
//  
//
//  Created by Haithem Ben harzallah on 09/11/2019.
//

import UIKit

public extension UIView {

    /// Create a Brik view with the view in it.
    /// - Note: It creates the view only if it is not a Brik view else it returns himself.
    func toLego() -> Brik {
        if self is Brik {
            return self as! Brik
        } else {
            return Brik { _ in
                self
            }
        }
    }
}
