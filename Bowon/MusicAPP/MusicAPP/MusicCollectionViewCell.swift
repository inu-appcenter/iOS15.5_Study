//
//  MusicCollectionViewCell.swift
//  MusicAPP
//
//  Created by Bowon Han on 11/1/23.
//

import UIKit
import SnapKit

final class MusicCollectionViewCell : UICollectionViewCell {
    var musicImageView : UIImageView = {
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
    
    func requestImageURL(data: Music) {
        guard let url = URL(string: data.imageName) else { return }
        
//        Task {
//            guard
//                let data = try? Data(contentsOf: url)
//                    //main 스레드에서 되는듯
//                    //그래서 네트워크끝날때까지 코드 line이 내려가지 못한듯,,
//                    //왜이지 ,,
//                    //task 쓰려면 ,,
//            else { return }
//            DispatchQueue.main.async{
//                self.musicImageView.image = UIImage(data: data)
//            }
//        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.musicImageView.image = image
                    }
                }
            }
        }
    }
}

// MARK: - UICollectionViewCell extension
extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
