//
//  TableViewHeaderView.swift
//  TodoUI
//
//  Created by Bowon Han on 11/7/23.
//

import UIKit
import SnapKit

protocol SelectSectionButtonDelegate : AnyObject {
    func selectSectionButtonTapped(forView view: TodoTableViewHeaderView)
}

class TodoTableViewHeaderView : UITableViewHeaderFooterView {
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
        label.font = UIFont.systemFont(ofSize: 27, weight: .heavy)
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
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setLayout()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func selectSectionButtonTapped(_:UIButton) {
        delegate?.selectSectionButtonTapped(forView: self)
    }
    
    private func setLayout(){
        headerStackView.addArrangedSubview(sectionNameLabel)
        headerStackView.addArrangedSubview(selectSectionPlusButton)
        
        addSubview(headerStackView)
        
        headerStackView.snp.makeConstraints {            
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-25)
        }
    }
}

// MARK: - UITableViewHeaderFooterView extension
extension UITableViewHeaderFooterView {
    static var identifier: String {
        return String(describing: self)
    }
}
