//
//  DetailViewController.swift
//  todoAPP
//
//  Created by Bowon Han on 11/16/23.
//

import UIKit
import SnapKit

class DetailViewController : UIViewController {
    private let saveData = SaveData.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.tintColor = .darkGreen

        setLayout()
    }
    
    var detailViewListName : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.backgroundColor = .darkYellow
        label.textColor = .black
        
        return label
    }()
    
    private var startDate : DateSelectView = {
        let view = DateSelectView()
        view.dateLabel.text = "start"
        
        return view
    }()
    
    private var endDate : DateSelectView = {
        let view = DateSelectView()
        view.dateLabel.text = "end"
        
        return view
    }()
    
    
    private func setLayout() {
        [detailViewListName,startDate,endDate].forEach {
            view.addSubview($0)
        }
        
        detailViewListName.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-40)
        }
        
        startDate.snp.makeConstraints {
            $0.top.equalTo(detailViewListName.snp.bottom).offset(30)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        endDate.snp.makeConstraints {
            $0.top.equalTo(startDate.snp.bottom)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
}
