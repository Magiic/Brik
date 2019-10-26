//
//  Style.swift
//  Brik
//
//  Created by Haithem Ben Harzallah on 24/10/2019.
//  Copyright © 2019 Haithem Ben Harzallah. All rights reserved.
//

import Foundation
import UIKit

public struct Style<View: UIView> {

    public let style: (View) -> Void

    public init(_ style: @escaping (View) -> Void) {
        self.style = style
    }

    /// Applies self to the view.
    public func apply(to view: View) {
        style(view)
    }
}

public protocol StyleApplicable {
    func apply<V>(_ style: Style<V>) -> V?
}

public extension StyleApplicable {
    @discardableResult
    func apply<V>(_ style: Style<V>) -> V? {
        guard let view = self as? V else { return nil }
        style.apply(to: view)
        return view
    }
}

public extension StyleApplicable where Self: UIView {
    @discardableResult
    func apply(_ style: Style<Self>) -> Self {
        style.apply(to: self)
        return self
    }
}

extension UIView: StyleApplicable {}

public extension Style {

    func add<V>(_ other: Style<V>) -> Style {
        return Style {
            self.apply(to: $0)
            other.apply(to: $0 as! V)
        }
    }

    func modifying(_ style: @escaping (View) -> Void) -> Style {
        return Style {
            self.apply(to: $0)
            style($0)
        }
    }

    mutating func modify(_ style: @escaping (View) -> Void) {
        self = modifying(style)
    }
}

public extension UIView {
    convenience init<V>(style: Style<V>) {
        self.init(frame: .zero)
        apply(style)
    }
}

public extension UILabel {
    convenience init<V>(text: String, style: Style<V>) {
        self.init(frame: .zero)
        self.text = text
        apply(style)
    }
}

public extension UIButton {
    convenience init(title: String, style: Style<UIButton>) {
        self.init(frame: .zero)
        setTitle(title, for: [])
        apply(style)
    }
}

public extension UITextField {
    convenience init(placeholder: String?, text: String? = nil, style: Style<UITextField>) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        self.text = text
        apply(style)
    }
}
