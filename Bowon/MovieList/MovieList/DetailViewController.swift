//
//  DetailViewController.swift
//  MovieList
//
//  Created by Bowon Han on 10/5/23.
//

import UIKit

class DetailViewController: UIViewController{
    var receiveImg: UIImage?
    var receiveTitle: String?
    var receivePlot: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setConstraintDetail()
        setNavigationButton()
        
        detailMovieImg.image = receiveImg
        detailMovieTitle.text = receiveTitle
        detailMoviePlot.text = receivePlot
    }
    
    
    //UI
    let detailMovieTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()

    let detailMoviePlot: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

    let detailMovieImg: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()

    
    //이전화면으로 돌아가는 메서드
    @objc func backVC(_:UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    //barbuttonitem
    private func setNavigationButton(){
        let backButton = UIBarButtonItem(title: "영화목록", style: .plain, target: self, action: #selector(backVC))
        navigationItem.leftBarButtonItem = backButton
    }
    
    //constraint
    private func setConstraintDetail(){
        
        self.view.addSubview(detailMovieTitle)
        self.view.addSubview(detailMovieImg)
        self.view.addSubview(detailMoviePlot)

        detailMovieTitle.translatesAutoresizingMaskIntoConstraints = false
        detailMovieImg.translatesAutoresizingMaskIntoConstraints = false
        detailMoviePlot.translatesAutoresizingMaskIntoConstraints = false

        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            detailMovieImg.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 60),
            detailMovieImg.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,constant: -60),
            detailMovieImg.topAnchor.constraint(equalTo: safeArea.topAnchor,constant: 60),
            detailMovieImg.heightAnchor.constraint(equalToConstant: 250),

            detailMovieTitle.leadingAnchor.constraint(equalTo: detailMovieImg.leadingAnchor),
            detailMovieTitle.topAnchor.constraint(equalTo: detailMovieImg.bottomAnchor,constant: 5),
            detailMovieTitle.heightAnchor.constraint(equalToConstant: 100),
            
            detailMoviePlot.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,constant: 60),
            detailMoviePlot.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -60),
            detailMoviePlot.topAnchor.constraint(equalTo: detailMovieTitle.bottomAnchor,constant: 20),
        ])
    }
}

