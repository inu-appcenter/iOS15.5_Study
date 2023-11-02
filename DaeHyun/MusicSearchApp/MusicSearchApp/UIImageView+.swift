//
//  UIImageView+.swift
//  MusicSearchApp
//
//  Created by 이대현 on 2023/11/02.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
}
