//
//  MovieDetailViewController.swift
//  MovieListApp
//
//  Created by 이대현 on 2023/10/04.
//

import UIKit
import SnapKit

class MovieDetailViewController: UIViewController {
    let movieInfo: MovieInfo
    
    private lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: movieInfo.imageName)
        return imageView
    }()
    
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
        label.text = movieInfo.title
        return label
    }()
    
    private lazy var movieDescription: UILabel = {
        let label = UILabel()
        label.text = movieInfo.description
        return label
    }()
    
    init(movie: MovieInfo) {
        self.movieInfo = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    private func layout() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(movieImage)
        movieImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(movieImage.snp.width)
        }
        
        self.view.addSubview(movieTitle)
        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(movieImage.snp.bottom).offset(20)
            make.left.equalTo(movieImage.snp.left).offset(20)
        }
        
        self.view.addSubview(movieDescription)
        movieDescription.snp.makeConstraints { make in
            make.top.equalTo(movieTitle.snp.bottom).offset(50)
            make.left.equalTo(movieTitle.snp.left)
        }
    }
}
