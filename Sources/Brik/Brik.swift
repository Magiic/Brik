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

    public subscript(childName: String) -> UIView {
        guard let child = container.allChilds().first(where: {$0.accessibilityIdentifier == childName}) else {
            fatalError("Cannot find child with accessibility identifier \(childName)")
        }

        return child
    }

    public subscript<C>(childName: String, class: C.Type) -> C where C: UIView {
        guard let child = container.allChilds().first(where: {$0.accessibilityIdentifier == childName}), let childAsType = child as? C else {
            fatalError("Cannot find child with accessibility identifier \(childName)")
        }

        return childAsType
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

    public enum GestureType {
        case tap, longPress, pinch
    }

    final class Gesture {
        let view: UIView
        let gesture: UIGestureRecognizer
        let action: () -> Void

        init(view: UIView, gesture: UIGestureRecognizer, action: @escaping () -> Void) {
            self.view = view
            self.gesture = gesture
            self.action = action
        }
    }

    final class ControlAction {
        let view: UIView
        let action: () -> Void

        init(view: UIView, action: @escaping () -> Void) {
            self.view = view
            self.action = action
        }
    }

    /**
     Initialize the brick with 2 or more `UIView` and `Brik`.
     - Parameter content: Content
     - Example of building a brick
        ````
        Brik { container in
            UILabel()
                .text("Hello")

            UITextField()
                .placeholder("Enter a name")
        }
        ````
     */
    public init(@BrikBuilder _ content: (Brik) -> UIView) {
        super.init(frame: .zero)
        self.container = content(self)
        addSubview(self.container)
        self.container.accessibilityIdentifier("brik_container_id")
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

    /// Called when the brick is moving to window.
    /// - Parameter tracking: Block  to execute when the brick appear.
    public func onAppear(_ tracking: @escaping (() -> Void)) -> Self {
        self.trackingOnAppear = tracking
        return self
    }

    /// Called when the brick moving out from window.
    /// - Parameter tracking: Block  to execute when the brick disappear.
    public func onDisappear(_ tracking: @escaping (() -> Void)) -> Self {
        self.trackingOnDisappear = tracking
        return self
    }

    // MARK: - Touch

    /// Called when a touches in the brick began.
    /// - Parameter tapped: Block to execute when touches began.
    public func onTap(_ tapped: @escaping () -> Void) -> Self {
        self.onTapped = tapped
        return self
    }

    // MARK: - Gesture

    /// Apply gesture on specified view
    /// - Parameter gesture: Type of gesture to apply. All of them are not yet integrated.
    /// - Parameter targetTag: The target tag view to apply gesture.
    /// - Parameter run: Block of code to execute when gesture is detected.
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

    /// Apply gesture on specified view with accessibility identifier
    /// - Parameter gesture: Type of gesture to apply. All of them are not yet integrated.
    /// - Parameter onChild: The target accessibility identifier view to apply gesture.
    /// - Parameter run: Block of code to execute when gesture is detected.
    @discardableResult
    public func gesture(_ gesture: Brik.GestureType, onChild child: String, run: @escaping (Brik, UIView, UIGestureRecognizer) -> Void) -> Self {
        guard let viewForGesture = container
            .allChilds()
            .first(where: {$0.accessibilityIdentifier == child})
            else { return self }

        let gestureSelected: UIGestureRecognizer
        switch gesture {
        case .tap:
            gestureSelected = UITapGestureRecognizer(target: self, action: #selector(handleGestureEvent(gesture:)))
        case .longPress:
            gestureSelected = UILongPressGestureRecognizer(target: self, action: #selector(handleGestureEvent(gesture:)))
        case .pinch:
            gestureSelected = UIPinchGestureRecognizer(target: self, action: #selector(handleGestureEvent(gesture:)))
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

    /// Action to execute for any UIControl. Use this method to execute a target action for a control.
    /// - Parameter targetTag: The target tag view to apply gesture.
    /// - Parameter event: A bitmask specifying the control-specific events for which the action method is called. Always specify at least one constant. Default touchUpInside.
    /// - Parameter run: Block of code to execute when event is triggered.
    @discardableResult
    public func action(onTagView targetTag: Int, event: UIControl.Event = .touchUpInside, _ run: @escaping (Brik, UIControl) -> Void) -> Self {
        guard let control = self[targetTag] as? UIControl else { return self }

        control.addTarget(self, action: #selector(handleControlAction(sender:)), for: event)

        trackedControlActions.append(ControlAction(view: control, action: { [unowned self] in
            run(self, control)
        }))

        return self
    }

    /// Action to execute for any UIControl. Use this method to execute a target action for a control.
    /// - Parameter onChild: The target accessibility identifier view to apply gesture.
    /// - Parameter event: A bitmask specifying the control-specific events for which the action method is called. Always specify at least one constant. Default touchUpInside.
    /// - Parameter run: Block of code to execute when event is triggered.
    @discardableResult
    public func action(onChild child: String, event: UIControl.Event = .touchUpInside, _ run: @escaping (Brik, UIControl) -> Void) -> Self {
        guard
            let control = container
                .allChilds()
                .first(where: {$0.accessibilityIdentifier == child}) as? UIControl
            else { return self }

        control.addTarget(self, action: #selector(handleControlAction(sender:)), for: event)

        trackedControlActions.append(ControlAction(view: control, action: { [unowned self] in
            run(self, control)
        }))

        return self
    }

    /// Observe editing changed in UITextField to execute a specified code.
    /// - Parameters:
    ///   - targetTag: The target tag view to apply gesture. It should be a UITextField control.
    ///   - run: Block of code to execute when event is triggered.
    @discardableResult
    public func editingChanged(
        onTagView targetTag: Int,
        run: @escaping (Brik) -> Void) -> Self {

        guard let control = self[targetTag] as? UITextField else { return self }
        control.addTarget(self, action: #selector(handleControlAction(sender:)), for: .editingChanged)

        trackedControlActions.append(ControlAction(view: control, action: {
            run(self)
        }))

        return self
    }

    /// Observe editing changed in UITextField to execute a specified code.
    /// - Parameters:
    ///   - onChild: The target accessibility identifier view to apply gesture. It should be a UITextField control.
    ///   - run: Block of code to execute when event is triggered.
    @discardableResult
    public func editingChanged(
        onChild child: String,
        run: @escaping (Brik) -> Void) -> Self {

        guard let control = container
            .allChilds()
            .first(where: {$0.accessibilityIdentifier == child}) as? UITextField
            else { return self }
        control.addTarget(self, action: #selector(handleControlAction(sender:)), for: .editingChanged)

        trackedControlActions.append(ControlAction(view: control, action: { [unowned self] in
            run(self)
        }))

        return self
    }

    /// Find a UIView child with corresponding name on the hierarchy of the brik and execute the specified block code.
    /// - Parameter childName: Name of the child.
    /// - Parameter class: Class type of the child specified in argument.
    /// - Parameter run: Block of code to execute.
    @discardableResult
    public func child<T>(childName: String, class: T.Type, _ run: @escaping (T) -> Void) -> Self where T: UIView {
        guard let control = container
            .allChilds()
            .first(where: {$0.accessibilityIdentifier == childName}) as? T
            else { return self }

        run(control)

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
    /**
    Initialize the brick with 2 or more `UIView` and `Brik`.
    - Parameter content: Content
    - Example of building a brick
       ````
       VBrik(alignment: .center) { container in
           UILabel()
               .text("Hello")

           UITextField()
               .placeholder("Enter a name")
       }
       ````
    */
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

    @discardableResult
    public func customSpacing(spacing: CGFloat, after tag: Int) -> Self {
        guard let vStack = container as? UIStackView else { return self }
        vStack.setCustomSpacing(spacing, after:  self[tag])
        return self
    }
}

public class HBrik: Brik {
    /**
    Initialize the brick with 2 or more `UIView` and `Brik`.
    - Parameter content: Content
    - Example of building a brick
       ````
       HBrik(alignment: .bottom) { container in
           UILabel()
               .text("Hello")

           UITextField()
               .placeholder("Enter a name")
       }
       ````
    */
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

    @discardableResult
    public func customSpacing(spacing: CGFloat, after tag: Int) -> Self {
        guard let hStack = container as? UIStackView else { return self }
        hStack.setCustomSpacing(spacing, after:  self[tag])
        return self
    }
}
