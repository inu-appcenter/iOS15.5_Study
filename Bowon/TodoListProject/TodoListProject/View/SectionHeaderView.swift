//
//  SectionHeaderView.swift
//  TodoListProject
//
//  Created by Bowon Han on 11/19/23.
//

import UIKit
import SnapKit

protocol SelectSectionButtonDelegate : AnyObject {
    func selectSectionButtonTapped(forView view: SectionHeaderView)
}

class SectionHeaderView : UIView {
    weak var delegate : SelectSectionButtonDelegate?
    
    private lazy var headerStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .center
    
        return stackView
    }()
    
    var sectionNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return label
    }()
    
    lazy var selectSectionPlusButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .darkGreen
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.addTarget(self, action: #selector(selectSectionButtonTapped), for: .touchUpInside)

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc func selectSectionButtonTapped(_:UIButton) {
        delegate?.selectSectionButtonTapped(forView: self)
    }
    
    private func setLayout(){
        selectSectionPlusButton.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(30)
        }
        
        headerStackView.addArrangedSubview(sectionNameLabel)
        headerStackView.addArrangedSubview(selectSectionPlusButton)
        
        addSubview(headerStackView)
        
        headerStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(-5)
        }
    }
}

