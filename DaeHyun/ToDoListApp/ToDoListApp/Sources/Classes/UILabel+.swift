//
//  UILabel+.swift
//  ToDoListApp
//
//  Created by 이대현 on 2023/11/14.
//

import UIKit

extension UILabel {
    func strikethrough(from text: String?, at range: String?) {
        guard let text = text,
              let range = range else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes([
            NSAttributedString.Key.strikethroughStyle:
                NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.strikethroughColor:
                UIColor.lightGray
        ], range: NSString(string: text).range(of: range))
        self.attributedText = attributedString
    }
    
    func unsetStrikethrough(from text: String?, at range: String?) {
        guard let text = text, let range = range else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.removeAttribute(NSAttributedString.Key.strikethroughStyle,
                                         range: NSString(string: text).range(of: range))
        self.attributedText = attributedString
    }
}
