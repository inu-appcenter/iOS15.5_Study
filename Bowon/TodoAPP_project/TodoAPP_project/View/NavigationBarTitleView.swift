//
//  NavigationBarTitleView.swift
//  TodoAPP_project
//
//  Created by Bowon Han on 11/26/23.
//

import UIKit
import SnapKit

final class NavigationBarTitleView : UIView {
    var vcTitle : String
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .darkGreen
        label.text = vcTitle
        label.font = UIFont.systemFont(ofSize: 27, weight: .heavy)

        return label
    }()
    
    init(vcName: String) {
        self.vcTitle = vcName
        
        super.init(frame: CGRect.zero)
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-5)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}
