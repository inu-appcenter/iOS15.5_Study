//
//  ViewController.swift
//  MovieListApp
//
//  Created by 이대현 on 2023/10/04.
//

import SnapKit
import UIKit

final class MovieListViewController: UIViewController {
    private lazy var testLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        self.view.addSubview(testLabel)
        testLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }


}

