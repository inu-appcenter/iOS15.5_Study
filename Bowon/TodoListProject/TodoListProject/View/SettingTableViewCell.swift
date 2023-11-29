//
//  SettingTableViewCell.swift
//  TodoListProject
//
//  Created by Bowon Han on 11/19/23.
//

import UIKit
import SnapKit

final class SettingTableViewCell : UITableViewCell {
    var settingTitleLabel : UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setLayout(){
        contentView.addSubview(settingTitleLabel)
        
        settingTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(15)
            $0.bottom.equalToSuperview().offset(-15)
            $0.trailing.equalToSuperview().offset(15)
        }
    }
}

// MARK: - UITableViewCell extension
extension UITableViewCell {
    static var settingIdentifier: String {
        return String(describing: self)
    }
}
