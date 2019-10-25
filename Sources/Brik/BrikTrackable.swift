//
//  BrikTrackable.swift
//  Brik
//
//  Created by Haithem Ben Harzallah on 24/10/2019.
//  Copyright © 2019 Haithem Ben Harzallah. All rights reserved.
//

import Foundation

public protocol BrikTrackable: AnyObject {
    var trackingOnAppear: (() -> Void)? { get }
    var trackingOnDisappear: (() -> Void)? { get }

    func onAppear(_ tracking: @escaping (() -> Void)) -> Self
    func onDisappear(_ tracking: @escaping (() -> Void)) -> Self
}
