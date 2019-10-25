//
//  BrikBuilder.swift
//  Brik
//
//  Created by Haithem Ben Harzallah on 24/10/2019.
//  Copyright © 2019 Haithem Ben Harzallah. All rights reserved.
//

import UIKit

@_functionBuilder
public struct VBrikBuilder {
    public static func buildBlock(_ views: UIView...) -> UIView {
        views.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }
}

@_functionBuilder
public struct HBrikBuilder {
    public static func buildBlock(_ views: UIView...) -> UIView {
        views.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }
}

@_functionBuilder
public struct BrikBuilder {
    public static func buildBlock(_ views: UIView...) -> UIView {
        let view = UIView(frame: .zero)
        views.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        })
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }
}

@_functionBuilder
public struct BrikConstraint {
    public static func buildBlock(_ constraints: NSLayoutConstraint...) -> [NSLayoutConstraint] {
        return constraints
    }
}
