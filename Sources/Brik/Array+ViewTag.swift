//
//  Array+ViewTag.swift
//  Brik
//
//  Created by Haithem Ben Harzallah on 24/10/2019.
//  Copyright © 2019 Haithem Ben Harzallah. All rights reserved.
//

import UIKit

public extension Array where Element: UIView {

    /// Get the first view associated to the class
    /// - Parameter class: Class type
    func first<T>(class: T.Type) -> T where T: UIView {
        guard let findView = self.first(where: { $0 is T }), let theView = findView as? T else {
            fatalError("Cannot find view with class \(T.self)")
        }

        return theView
    }

    /// Get the view associated with tag and matching with class type
    /// - Parameter tag: Tag of the view
    /// - Parameter class: Class type of the view
    func view<T>(with tag: Int, class: T.Type) -> T where T: UIView {
        guard let findView = self.first(where: { $0.tag == tag }), let theView = findView as? T else {
            fatalError("Cannot find view with tag \(tag) and class \(T.self)")
        }

        return theView
    }

    /// get the view associated to the tag
    /// - Parameter tag: Tag of the view
    func view(with tag: Int) -> UIView {
        guard let findView = self.first(where: { $0.tag == tag }) else {
            fatalError("Cannot find view with tag \(tag)")
        }

        return findView
    }
}
