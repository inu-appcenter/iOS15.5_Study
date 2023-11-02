//
//  MusicCollectionViewCell.swift
//  MusicAPP
//
//  Created by Bowon Han on 11/1/23.
//

import UIKit
import SnapKit

final class MusicCollectionViewCell : UICollectionViewCell {
    private let musicImageView : UIImageView = {
        let imageView = UIImageView()

        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout(){
        addSubview(musicImageView)
        
        musicImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with music: Music) {
        musicImageView.image = UIImage(named: music.imageName)
    }
}

// MARK: - UICollectionViewCell extension
extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

