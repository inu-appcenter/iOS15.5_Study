//
//  MemberListViewCell.swift
//  MemberList
//
//  Created by Bowon Han on 10/8/23.
//

import UIKit

class MemberListViewCell:UITableViewCell{
// MARK: - UI
    let memberNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let memberAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
    let memberPicturesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.image = UIImage(named: "배트맨.png")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

// MARK: - for constraint
    private func setConstraint(){
        contentView.addSubview(memberNameLabel)
        contentView.addSubview(memberAddressLabel)
        contentView.addSubview(memberPicturesImageView)

        memberNameLabel.translatesAutoresizingMaskIntoConstraints = false
        memberAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        memberPicturesImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            memberNameLabel.leadingAnchor.constraint(equalTo: memberPicturesImageView.trailingAnchor, constant: 17),
            memberNameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: 2),
            
            memberAddressLabel.topAnchor.constraint(equalTo: memberNameLabel.bottomAnchor, constant: 5),
            memberAddressLabel.leadingAnchor.constraint(equalTo: memberPicturesImageView.trailingAnchor, constant: 17),
            memberAddressLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
            
            memberPicturesImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            memberPicturesImageView.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: 10),
            memberPicturesImageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
            memberPicturesImageView.widthAnchor.constraint(equalToConstant: 50),
            memberPicturesImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - UITableViewCell extension
extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

