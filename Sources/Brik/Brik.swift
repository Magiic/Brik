//
//  Brik.swift
//  Brik
//
//  Created by Haithem Ben Harzallah on 24/10/2019.
//  Copyright © 2019 Haithem Ben Harzallah. All rights reserved.
//

import UIKit

// MARK: - Brik

/**
 Brick is an UIView that allow to build a complex hierarchy
 */
public class Brik: UIView, BrikTrackable {

    // MARK: - Properties

    // MARK: Accessing child view

    public var childs: [UIView] {
        container.subviews
    }

    public subscript(tag: Int) -> UIView {
        childs.view(with: tag)
    }

    public subscript<C>(tag: Int, class: C.Type) -> C where C: UIView {
        childs.view(with: tag, class: C.self)
    }

    // MARK: Brik Trackable

    public var trackingOnAppear: (() -> Void)? = nil
    public var trackingOnDisappear: (() -> Void)? = nil

    // MARK: Container

    /// Contains all subviews
    public var container: UIView = UIView()

    // MARK: Private

    private var onTapped: (() -> Void)?
    private var trackedGestures: [Brik.Gesture] = []
    private var trackedControlActions: [ControlAction] = []
    var customConstraints: [NSLayoutConstraint] = []

    public enum GestureType {
        case tap, longPress, pinch
    }

    public final class Gesture {
        let view: UIView
        let gesture: UIGestureRecognizer
        let action: () -> Void

        init(view: UIView, gesture: UIGestureRecognizer, action: @escaping () -> Void) {
            self.view = view
            self.gesture = gesture
            self.action = action
        }
    }

    public final class ControlAction {
        let view: UIView
        let action: () -> Void

        init(view: UIView, action: @escaping () -> Void) {
            self.view = view
            self.action = action
        }
    }

    public init(@BrikBuilder _ content: (Brik) -> UIView) {
        super.init(frame: .zero)
        self.container = content(self)
        addSubview(self.container)
        self.container.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.container.topAnchor.constraint(equalTo: topAnchor),
            self.container.bottomAnchor.constraint(equalTo: bottomAnchor),
            self.container.leftAnchor.constraint(equalTo: leftAnchor),
            self.container.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func didMoveToWindow() {
        super.didMoveToWindow()
        if window == nil {
            trackingOnDisappear?()
        } else {
            trackingOnAppear?()
        }
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        onTapped?()
    }

    // MARK: - Tracking

    public func onAppear(_ tracking: @escaping (() -> Void)) -> Self {
        self.trackingOnAppear = tracking
        return self
    }

    public func onDisappear(_ tracking: @escaping (() -> Void)) -> Self {
        self.trackingOnDisappear = tracking
        return self
    }

    // MARK: - Touch

    public func onTap(_ tapped: @escaping () -> Void) -> Self {
        self.onTapped = tapped
        return self
    }

    // MARK: - Gesture

    @discardableResult
    public func gesture(_ gesture: Brik.GestureType, onTagView targetTag: Int, run: @escaping (Brik, UIView, UIGestureRecognizer) -> Void) -> Self {
        guard let viewForGesture = subviews.first?.subviews.view(with: targetTag) else { return self }

        let gestureSelected: UIGestureRecognizer
        switch gesture {
        case .tap:
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleGestureEvent(gesture:)))
            gestureSelected = tap
        case .longPress:
            let long = UILongPressGestureRecognizer(target: self, action: #selector(handleGestureEvent(gesture:)))
            gestureSelected = long
        case .pinch:
            let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handleGestureEvent(gesture:)))
            gestureSelected = pinch
        }

        gestureSelected.name = UUID().uuidString

        viewForGesture.isUserInteractionEnabled = true
        viewForGesture.addGestureRecognizer(gestureSelected)

        trackedGestures.append(Brik.Gesture(view: viewForGesture, gesture: gestureSelected, action: { [weak self] in
            guard let self = self else { return }
            run(self, viewForGesture, gestureSelected)
        }))

        return self
    }

    @objc
    fileprivate func handleGestureEvent(gesture: UIGestureRecognizer) {
        guard let view = gesture.view else { return }
        guard let firstGesture = trackedGestures.first(where: {
            $0.view.tag == view.tag && $0.gesture.name == gesture.name
        }) else { return }

        firstGesture.action()
    }

    // MARK: - Target UIControl

    @discardableResult
    public func action(onTagView targetTag: Int, event: UIControl.Event = .touchUpInside, _ run: @escaping (UIControl) -> Void) -> Self {
        guard let control = self[targetTag] as? UIControl else { return self }

        control.addTarget(self, action: #selector(handleControlAction(sender:)), for: event)

        trackedControlActions.append(ControlAction(view: control, action: {
            run(control)
        }))

        return self
    }

    @objc
    fileprivate func handleControlAction(sender: UIControl) {
        guard let firstControl = trackedControlActions.first(where: {
            $0.view.tag == sender.tag
        }) else { return }

        firstControl.action()
    }
}

public class VBrik: Brik {
    public override init(@VBrikBuilder _ content: (Brik) -> UIView) {
        super.init(content)
        if let vStack = container as? UIStackView {
            vStack.alignment = .center
            vStack.spacing = 0
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class HBrik: Brik {
    public override init(@HBrikBuilder _ content: (Brik) -> UIView) {
        super.init(content)
        if let vStack = container as? UIStackView {
            vStack.alignment = .center
            vStack.spacing = 0
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
