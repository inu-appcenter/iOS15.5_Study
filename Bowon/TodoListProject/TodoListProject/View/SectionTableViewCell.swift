//
//  SectionTableViewCell.swift
//  TodoListProject
//
//  Created by Bowon Han on 11/19/23.
//

import UIKit
import SnapKit

final class SectionTableViewCell : UITableViewCell {
    let sectionNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setLayout() {
        contentView.addSubview(sectionNameLabel)
        
        sectionNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview().offset(-15)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(30)
        }
    }
}

