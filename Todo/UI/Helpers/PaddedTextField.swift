//
//  PaddedTextField.swift
//  Todo
//
//  Created by Drew Barnes on 20/09/2021.
//

import UIKit

class PaddedTextField: UITextField {
    private var _padding: CGFloat = 15.0

    @IBInspectable
    var padding: CGFloat {
        get { _padding }
        set {
            _padding = newValue
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: _padding, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        textRect(forBounds: bounds)
    }
}
