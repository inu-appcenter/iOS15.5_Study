//
//  MusicCollectionViewCell.swift
//  MusicSearchApp
//
//  Created by 이대현 on 2023/11/01.
//

import SnapKit
import UIKit

final class MusicCollectionViewCell: UICollectionViewCell {
    private lazy var musicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "pencil")
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    private lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.text = "artist"
        label.font = label.font.withSize(15)
        label.textColor = .gray
        return label
    }()
    
    private lazy var collectionLabel: UILabel = {
        let label = UILabel()
        label.text = "collection"
        label.font = label.font.withSize(15)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "date"
        label.font = label.font.withSize(15)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubview(musicImageView)
        musicImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(musicImageView.snp.height)
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(musicImageView.snp.right).offset(10)
            make.top.equalTo(musicImageView.snp.top)
        }
        
        self.addSubview(artistLabel)
        artistLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        self.addSubview(collectionLabel)
        collectionLabel.snp.makeConstraints { make in
            make.left.equalTo(artistLabel)
            make.right.equalTo(self.safeAreaLayoutGuide).offset(-10)
            make.top.equalTo(artistLabel.snp.bottom).offset(10)
        }
        
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(collectionLabel)
            make.top.equalTo(collectionLabel.snp.bottom).offset(10)
        }
    }
    
    func setupUI(data: MusicData) {
        if let imageUrl = URL(string: data.artistViewUrl) {
            print(data.artistViewUrl)
            self.musicImageView.load(url: imageUrl)
        }
        self.titleLabel.text = data.trackName
        self.artistLabel.text = data.artistName
        self.collectionLabel.text = data.collectionName
        
        let milisecond = data.trackTimeMillis
        let dateVar = Date.init(timeIntervalSinceNow: TimeInterval(milisecond)/1000)
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        self.dateLabel.text = dateFormatter.string(from: dateVar)
    }
}

// MARK: - UICollectionViewCell extension
extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
