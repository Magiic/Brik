//
//  UITableView+Modifier.swift
//  Brik
//
//  Created by Haithem Ben Harzallah on 24/10/2019.
//  Copyright © 2019 Haithem Ben Harzallah. All rights reserved.
//

import UIKit

public extension UITableView {

    @discardableResult
    func register<T>(cell: T.Type) -> Self where T: UITableViewCell {
        register(T.self, forCellReuseIdentifier: String(describing: type(of: cell)))
        return self
    }

    @discardableResult
    func footerView(_ footer: UIView) -> Self {
        self.tableFooterView = footer
        return self
    }

    @discardableResult
    func footerView(_ block: (UITableView) -> UIView) -> Self {
        self.tableFooterView = block(self)
        return self
    }

    @discardableResult
    func rowHeight(_ height: CGFloat = UITableView.automaticDimension) -> Self {
        self.rowHeight = height
        return self
    }

    @discardableResult
    func estimatedRowHeight(_ height: CGFloat) -> Self {
        self.estimatedRowHeight = height
        return self
    }

    @discardableResult
    func dataSource(_ dataSource: UITableViewDataSource) -> Self {
        self.dataSource = dataSource
        return self
    }

    @discardableResult
    func delegate(_ delegate: UITableViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }

    @discardableResult
    func separator(_ insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) -> Self {
        self.separatorInset = insets
        return self
    }
}
