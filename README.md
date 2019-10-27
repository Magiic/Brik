# Brik

A declarative and simple way to build user interfaces with UIKit and the power of Swift language.

```swift
VBrik { _ in
    UILabel()
        .text("Username")
        .font(.preferredFont(forTextStyle: .headline))
        .color(.black)
        .textAlignment(.center)

    UITextField()
        .placeholder("Enter an email")
}
.add(in: self.view, constraints: .center)
```

![Brik example](https://i.ibb.co/sym8QSm/Simulator-Screen-Shot-i-Phone-11-2019-10-26-at-18-31-44.png)

SwiftUI is a great tool however it is available only for iOS13 or plus. For those need to be compatible with old versions there are not lot of solutions to write a clear and easy code that can be similary to SwiftUI.
Brik attempts to bring an alternative to SwiftUI for UIKit development to make great applications easy to write and read.
Furthermore, Brik is not a black box complex to understand and debug. This is a simple UIView that you can use with any other View in existing project.

For now, the framework is focused on UIKit and iOS plateform.

## Introduction
Brik is an `UIView` that can be composable with other **Brik** or `UIView` to form complex views. It was designed in the goal to fit the principle of [Atomic Design](http://atomicdesign.bradfrost.com/chapter-2/).

## Installation
It required the version **Swift 5.1** minimum.

### Swift Package Manager
The Swift Package Manager is a tool for automating the distribution of Swift code and is integrated into Xcode since **Xcode 11** version.

```
dependencies: [
    .package(url: "https://github.com/Magiic/Brik", from: "0.0.9")
]
```

## Usage
The library comes with 3 types of brick. With these bricks we can compose them to build a complex views similar to molecules or organisms in atomic design.

### VBrik
This is the brick to build a vertical stack view.

Here a simple example to build a login form and add it to the view controller.

```swift
VBrik(spacing: 10) { _ in
	UILabel()
	    .text("Username")
	    .font(.preferredFont(forTextStyle: .headline))
	    .color(.black)
	    .textAlignment(.center)
	
	UITextField()
	    .placeholder("Enter an email")
	
	UITextField()
	    .placeholder("Enter an password")
	    .isSecureTextEntry(true)
	
	UIButton()
	    .tag(1)
	    .title("Login")
	    .color(.white)
	    .backgroundColor(.red)
}
.add(in: self.view, constraints: .center)
.action(onTagView: 1, event: .touchUpInside) { _ in
	print("send")
}
```

### HBrik
This is the brick to build a horizontal stack view.

Here a simple example to build a label with a textfield.

```swift
HBrik(alignment: .bottom, spacing: 25) { _ in
    UILabel()
        .text("Name:")
        .font(.preferredFont(forTextStyle: .title2))
        .color(.black)
        .lines(1)

    UITextField()
        .placeholder("Enter a name")
}
```

### Brik
This is the brick you use if you need a more complex layout where you have to work with specific constraints.

```swift
let brickA = VBrik(spacing: 10) { _ in
    UILabel()
        .text("Username")
        .font(.preferredFont(forTextStyle: .headline))
        .color(.black)
        .textAlignment(.center)

    UITextField()
        .placeholder("Enter an email")

    UITextField()
        .placeholder("Enter an password")
        .isSecureTextEntry(true)

}

let brickB = HBrik(spacing: 20) { _ in
    UIButton()
        .title("Sign in")
        .color(.red)

    UIButton()
        .attributedTitle(
            .init(string: "Sign up", attributes: [
                .font: UIFont.preferredFont(forTextStyle: .body),
                .foregroundColor: UIColor.blue,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]))
}

Brik { _ in
    brickA.tag(1)
    brickB.tag(2)
}
.constraints({ (brick, _) in
    brick[1].topAnchor.constraint(equalTo: brick.topAnchor)
    brick[1].leadingAnchor.constraint(equalTo: brick.leadingAnchor)
    brick[1].trailingAnchor.constraint(equalTo: brick.trailingAnchor)
    brick[1].bottomAnchor.constraint(equalTo: brick[2].topAnchor, constant: -16)

    brick[2].centerXAnchor.constraint(equalTo: brick.centerXAnchor)
    brick[2].bottomAnchor.constraint(lessThanOrEqualTo: brick.bottomAnchor, constant: -12)
})
.add(in: self.view, constraints: .center)
```

> **Note**: VBrik and HBrik inherited both from Brik

### Style
To make your views more reusable through your application, you can adopt the `Style` architecture provided by Brik.

Style can be used with any `UIView`. If we transpose in Atomic Design, Styles are atoms or molecules.

```swift
struct StyleSheet {

    static let abc = Style<UILabel> {
        $0.font = UIFont.preferredFont(forTextStyle: .body)
        $0.textColor = .red
        $0.numberOfLines = 0
    }
}

VBrik(spacing: 10) { _ in
    UILabel()
        .text("Username")
        .apply(StyleSheet.abc)

    UITextField()
        .placeholder("Enter an email")

}
```

> **Tip**: Organize your styles with `struct` or `enum` to have autocompletion.

### Add View & Constraints

To add the brick into another brick or view, you have multiple convenient functions like this:

```swift
add(in: self.view, constraints: .center)
```

It will place the brick to the center of the view specified in first argument.

`constraints` argument expected a value of type `LayoutBaseType`.

```swift
public enum LayoutBaseType {
	case pinToEdge
	case pinToEdgePadding(CGFloat)
	case pinToEdgeInsets(UIEdgeInsets)
	case center
	case centerPadding(CGFloat)
	case centerInsets(UIEdgeInsets)
	case height(CGFloat)
	case width(CGFloat)
	case size(CGSize)
}
```

But if you need to set up your own auto layout constraints you can use the following function:

```swift
.add(in: self.view, { (brick, subviews) -> [NSLayoutConstraint] in
    ...
})
```

With the above function, you can set the constraints for the brick and his subviews.

> **Tip**: You can access to the subview with a specified tag:

```swift
Brik { _ in
    brickA.tag(1)
    brickB.tag(2)
}
.constraints({ (brick, _) in
    brick[1].topAnchor.constraint(equalTo: brick.topAnchor)
    brick[1].leadingAnchor.constraint(equalTo: brick.leadingAnchor)
    brick[1].trailingAnchor.constraint(equalTo: brick.trailingAnchor)
    brick[1].bottomAnchor.constraint(equalTo: brick[2].topAnchor, constant: -16)

    brick[2].centerXAnchor.constraint(equalTo: brick.centerXAnchor)
    brick[2].bottomAnchor.constraint(lessThanOrEqualTo: brick.bottomAnchor, constant: -12)

    brick.heightAnchor.constraint(equalToConstant: 200)
})
.add(in: self.view, constraints: .center)
```

### Action

You can add a target action to a control like below:

```swift
let brickA = VBrik(spacing: 10) { _ in
    UILabel()
        .text("Username")
        .font(.preferredFont(forTextStyle: .headline))
        .color(.black)
        .textAlignment(.center)

    UITextField()
        .tag(2)
        .placeholder("Enter an email")

}

let brickB = HBrik(spacing: 20) { ... }

Brik { container in
    brickA
        .tag(1)
        .action(onTagView: 2, event: .editingChanged) { control in
            // These 2 following lines are similar
            print(control[UITextField.self]?.text)
            print(container[1, Brik.self][2, UITextField.self].text)
        }
    brickB.tag(2)
}
```

### Gesture

You can add gestures easily with:

```swift
.gesture(.tap, onTagView: 5, run: { (brik, gestureView, gesture) in
    ...
})
```

```swift
.onTap {
    ...
}
```

### Track Cycle

If you need execute code when the brick appear or disappear, like tracking event set up, you can use the following functions:

```swift
.onAppear {
    ...
}
```

```swift
.onDisappear {
    ...
}
```



