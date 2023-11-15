//
//  Extension.swift
//  TodoUI
//
//  Created by Bowon Han on 11/7/23.
//

import UIKit

// MARK: - UIColor extension
extension UIColor {
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
            
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
            
        assert(hexFormatted.count == 6, "Invalid hex code used.")
            
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
            
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    static let darkGreen : UIColor = UIColor(hexCode: "274e13")
}

// MARK: - UILabel extension
extension UILabel {
    func strikethroughAndChangeLineColor(from text: String?, at range: String?) {
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

