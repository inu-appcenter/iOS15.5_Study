//
//  MemberTableViewCell.swift
//  MemberListApp
//
//  Created by 이대현 on 2023/10/11.
//

import UIKit

final class MemberTableViewCell: UITableViewCell {
    static let cellId = "memberCell"
    
    private lazy var memberImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubview(memberImageView)
        memberImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(memberImageView.snp.height)
        }
        
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(memberImageView.snp.right).offset(10)
            make.top.equalTo(memberImageView.snp.top)
        }
        
        self.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.bottom.equalTo(memberImageView.snp.bottom)
        }
    }
    
    func setupUI(data: MemberData) {
        memberImageView.image = UIImage(named: data.imageName)
        nameLabel.text = data.name
        addressLabel.text = data.address
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        memberImageView.layer.cornerRadius = memberImageView.frame.height / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

