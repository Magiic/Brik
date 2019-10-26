//
//  Brik+Constraints.swift
//  Brik
//
//  Created by Haithem Ben Harzallah on 24/10/2019.
//  Copyright © 2019 Haithem Ben Harzallah. All rights reserved.
//

import UIKit

public extension Brik {

    @discardableResult
    func constraints(@BrikConstraint _ cons: (Brik, [UIView]) -> [NSLayoutConstraint]) -> Self {
        let c = cons(self, container.subviews)
        NSLayoutConstraint.activate(c)
        return self
    }

    @discardableResult
    func add(in view: UIView, @BrikConstraint _ cons: (Brik, [UIView]) -> [NSLayoutConstraint]) -> Self {
        view.addSubview(self)
        let c = cons(self, container.subviews)
        NSLayoutConstraint.activate(c)
        return self
    }

    @discardableResult
    func add(in view: UIView, constraints: LayoutBaseType) -> Self {
        view.addSubview(self)
        self.constraints(constraints, view: view)
        return self
    }
}
