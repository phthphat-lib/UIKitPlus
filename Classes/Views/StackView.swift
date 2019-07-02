//
//  StackView.swift
//  UIKitPlus
//
//  Created by Mihael Isaev on 30/06/2019.
//

import UIKit

@available(iOS 9.0, *)
open class StackView: UIStackView, DeclarativeView {
    public var declarativeView: StackView { return self }
    
    public var _circleCorners: Bool = false
    public var _customCorners: CustomCorners?
    public lazy var _borders = Borders()
    
    public init () {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        onLayoutSubviews()
    }
    
    // Mask: Axis
    
    @discardableResult
    public func axis(_ axis: NSLayoutConstraint.Axis) -> StackView {
        self.axis = axis
        return self
    }
}