//
//  MovieTableViewCell.swift
//  MovieListApp
//
//  Created by 이대현 on 2023/10/04.
//

import SnapKit
import UIKit

class MovieTableViewCell: UITableViewCell {
    static let cellId = "movieCell"
    
    private lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var movieDescription: UILabel = {
        let label = UILabel()
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
        self.addSubview(movieImage)
        movieImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(movieImage.snp.height)
        }
        
        self.addSubview(movieTitle)
        movieTitle.snp.makeConstraints { make in
            make.left.equalTo(movieImage.snp.right).offset(10)
            make.top.equalTo(movieImage.snp.top).offset(10)
        }
        
        self.addSubview(movieDescription)
        movieDescription.snp.makeConstraints { make in
            make.left.equalTo(movieTitle.snp.left)
            make.bottom.equalTo(movieImage.snp.bottom).offset(-10)
        }
    }
    
    func setupUI(movie: MovieInfo) {
        movieImage.image = UIImage(named: movie.imageName)
        movieTitle.text = movie.title
        movieDescription.text = movie.description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
