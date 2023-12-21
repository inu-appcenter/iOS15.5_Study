//
//  DateSelectView.swift
//  TodoAPP_project
//
//  Created by Bowon Han on 11/26/23.
//

import UIKit
import SnapKit

class DateSelectView : UIView {
    private lazy var dateStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .center

        return stackView
    }()

    let dateLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    lazy var dataPicker : UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = Locale(identifier: "ko-KR")
        
        return datePicker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStackViewLayout()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setStackViewLayout() {
        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(dataPicker)
    }
    
    private func setLayout() {
        addSubview(dateStackView)
        
        dateStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(50)
        }
    }
}
