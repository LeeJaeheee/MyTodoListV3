//
//  TextFieldExtension.swift
//  MyTodoList
//
//  Created by 이재희 on 2023/08/11.
//

import UIKit

extension UITextField {
    var placeholderColor: UIColor? {
        get {
            return self.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor
        }
        set {
            guard let placeholder = self.placeholder, let color = newValue else {
                return
            }
            let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: color]
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        }
    }
}
