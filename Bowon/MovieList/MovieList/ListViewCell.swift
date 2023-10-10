//
//  ListViewCell.swift
//  MovieList
//
//  Created by Bowon Han on 10/5/23.
//

import UIKit

class ListViewCell: UITableViewCell{
    
    static let identifier = "ListViewCell"
    
    let movieImg: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    let movieTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let moviePlot: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    //movieImg와 movieTitle의 constraint 잡기
    private func setConstraint(){
        contentView.addSubview(movieImg)
        contentView.addSubview(movieTitle)
        contentView.addSubview(moviePlot)


        movieImg.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        moviePlot.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([

            movieImg.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            movieImg.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            movieImg.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
            movieImg.widthAnchor.constraint(equalToConstant: 100),
            movieImg.heightAnchor.constraint(equalToConstant: 100),

            movieTitle.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 13),
            movieTitle.leadingAnchor.constraint(equalTo: movieImg.trailingAnchor, constant: 15),
            movieTitle.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 16),
            
            moviePlot.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 20),
            moviePlot.leadingAnchor.constraint(equalTo: movieImg.trailingAnchor, constant: 15),
            moviePlot.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])

    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
}

