//
//  UIView+Additions.swift
//  Todo
//
//  Created by Drew Barnes on 20/09/2021.
//

import UIKit

public extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable
    var borderColor: UIColor {
        get {
            let cgColor = layer.borderColor ?? UIColor.clear.cgColor
            return UIColor(cgColor: cgColor)
        }
        set { layer.borderColor = newValue.cgColor }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    // Load Views from Nib
    internal class func fromNib<T: UIView>() -> T {
        Bundle.main.loadNibNamed(
            String(describing: T.self), owner: nil, options: nil
        )!.first! as! T // swiftlint:disable:this force_cast
    }
}
