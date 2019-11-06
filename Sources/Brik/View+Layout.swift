//
//  View+Layout.swift
//  Brik
//
//  Created by Haithem Ben Harzallah on 24/10/2019.
//  Copyright © 2019 Haithem Ben Harzallah. All rights reserved.
//

import UIKit

public enum LayoutBaseType {
    case pinToEdge
    case pinToEdgePadding(CGFloat)
    case pinToEdgeInsets(UIEdgeInsets)
    case pinToUp
    case pinToUpInsets(UIEdgeInsets)
    case pinToBottom
    case pinToBottomInsets(UIEdgeInsets)
    case center
    case centerPadding(CGFloat)
    case centerInsets(UIEdgeInsets)
    case height(CGFloat)
    case width(CGFloat)
    case size(CGSize)
}

public extension UIView {

    func pinToEdge(_ view: UIView) {
        NSLayoutConstraint.activate(pinToEdgeConstraints(view))
    }

    func pinToEdgeConstraints(_ view: UIView) -> [NSLayoutConstraint] {
        return [
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
    }

    func pinToEdge(_ view: UIView, edgeInsets: UIEdgeInsets) {
        NSLayoutConstraint.activate(pinToEdgeConstraints(view, edgeInsets: edgeInsets))
    }

    func pinToEdgeConstraints(_ view: UIView, edgeInsets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return [
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: edgeInsets.top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -edgeInsets.bottom),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgeInsets.left),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edgeInsets.right)
        ]
    }

    func center(to view: UIView) {
        NSLayoutConstraint.activate(centerConstraints(to: view))
    }

    func centerConstraints(to view: UIView) -> [NSLayoutConstraint] {
        return [
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
    }

    func center(to view: UIView, edgeInsets: UIEdgeInsets) {
        NSLayoutConstraint.activate(centerConstraints(to: view, edgeInsets: edgeInsets))
    }

    func centerConstraints(to view: UIView, edgeInsets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return [
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: edgeInsets.top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -edgeInsets.bottom),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgeInsets.left),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edgeInsets.right)
        ]
    }

    @discardableResult
    func constraints(_ constraints: [NSLayoutConstraint], refresh: Bool = false) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
        if refresh {
            setNeedsLayout()
        }
        return self
    }

    @discardableResult
    func constraints(_ layoutBaseType: LayoutBaseType, view: UIView, refresh: Bool = false) -> Self {
        let const: [NSLayoutConstraint]
        switch layoutBaseType {
        case .pinToEdge:
            const = self.pinToEdgeConstraints(view)
        case .pinToEdgePadding(let padding):
            const = self.pinToEdgeConstraints(view, edgeInsets: .init(top: padding, left: padding, bottom: padding, right: padding))
        case .pinToEdgeInsets(let edgeInsets):
            const = self.pinToEdgeConstraints(view, edgeInsets: edgeInsets)
        case .pinToUp:
            const = [
                self.topAnchor.constraint(equalTo: view.topAnchor),
                self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                self.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
            ]
        case .pinToUpInsets(let edgeInsets):
            const = [
                self.topAnchor.constraint(equalTo: view.topAnchor, constant: edgeInsets.top),
                self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgeInsets.left),
                self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edgeInsets.right),
                self.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -edgeInsets.bottom)
            ]
        case .pinToBottom:
            const = [
                self.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
                self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        case .pinToBottomInsets(let edgeInsets):
            const = [
                self.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: edgeInsets.top),
                self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgeInsets.left),
                self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edgeInsets.right),
                self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -edgeInsets.bottom)
            ]
        case .center:
            const = self.centerConstraints(to: view)
        case .centerPadding(let padding):
            const = self.centerConstraints(to: view, edgeInsets: .init(top: padding, left: padding, bottom: padding, right: padding))
        case .centerInsets(let edgeInsets):
            const = self.centerConstraints(to: view, edgeInsets: edgeInsets)
        case .height(let value):
            const = [self.heightAnchor.constraint(equalToConstant: value)]
        case .width(let value):
            const = [self.widthAnchor.constraint(equalToConstant: value)]
        case .size(let size):
            const = [
                self.widthAnchor.constraint(equalToConstant: size.width),
                self.heightAnchor.constraint(equalToConstant: size.height)
            ]
        }

        constraints(const, refresh: refresh)

        return self
    }

    @discardableResult
    func constraints(_ layoutBaseType: LayoutBaseType, refresh: Bool = false) -> Self {
        let const: [NSLayoutConstraint]
        switch layoutBaseType {
        case .height(let value):
            const = [self.heightAnchor.constraint(equalToConstant: value)]
        case .width(let value):
            const = [self.widthAnchor.constraint(equalToConstant: value)]
        case .size(let size):
            const = [
                self.widthAnchor.constraint(equalToConstant: size.width),
                self.heightAnchor.constraint(equalToConstant: size.height)
            ]
        default:
            return self
        }

        constraints(const, refresh: refresh)

        return self
    }
}

