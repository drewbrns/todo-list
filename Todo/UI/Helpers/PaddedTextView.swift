//
//  PaddedTextView.swift
//  Todo
//
//  Created by Drew Barnes on 20/09/2021.
//

import UIKit

class PaddedTextView: UITextView {
    private var _padding: CGFloat = 15.0

    @IBInspectable
    var padding: CGFloat {
        get { _padding }
        set {
            _padding = newValue
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textContainerInset = UIEdgeInsets(top: _padding, left: _padding, bottom: _padding, right: _padding)
    }
}
