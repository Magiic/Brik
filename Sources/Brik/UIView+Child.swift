//
//  File.swift
//  
//
//  Created by Haithem Ben harzallah on 01/11/2019.
//

import UIKit

public extension UIView {

    subscript<C>(class: C.Type) -> C? where C: UIView {
        self as? C
    }

    func allChilds() -> [UIView] {
        var array = [UIView]()

        for subview in self.subviews {
            array.append(subview)
            array += subview.allChilds()
        }

        return array
    }

    func allChildsAdded() -> [UIView] {
        var array = [UIView]()

        for subview in self.subviews {
            array.append(subview)
            array += subview.allChilds()
        }

        return array.filter({$0.accessibilityIdentifier != "brik_container_id"})
    }
}
