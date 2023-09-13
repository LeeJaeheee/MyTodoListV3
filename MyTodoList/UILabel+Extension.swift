//
//  LabelExtension.swift
//  MyTodoList
//
//  Created by 이재희 on 2023/08/11.
//

import UIKit

extension UILabel {
    func setTextWithStrikethrough(_ text: String, isDone: Bool) {
        let attributedString = NSMutableAttributedString(string: text)
        if isDone {
            attributedString.addAttribute(
                NSAttributedString.Key.strikethroughStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: NSMakeRange(0, attributedString.length)
            )
        }
        self.attributedText = attributedString
    }
}
