//
//  ViewController.swift
//  MovieListApp
//
//  Created by 이대현 on 2023/10/04.
//

import SnapKit
import UIKit

final class MovieListViewController: UIViewController{
    private lazy var movieListTable: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.cellId)
        return tableView
    }()
    
    private let movieList = [
        MovieInfo(imageName: "batman.png", title: "배트맨", description: "배트맨이 출연하는 영화"),
        MovieInfo(imageName: "blackpanther.png", title: "블랙팬서", description: "와칸다의 왕위 계승자 티찰과 블랙팬서가 되다."),
        MovieInfo(imageName: "captain.png", title: "캡틴 아메리카", description: "캡틴 아메리카의 기원"),
        MovieInfo(imageName: "doctorstrange.png", title: "닥터 스트레인지", description: "도르마무 거래를 하러왔다"),
        MovieInfo(imageName: "hulk.png", title: "헐크", description: "헐크 멋있어요 굿"),
        MovieInfo(imageName: "ironman.png", title: "아이언맨", description: "아이언맨의 배우는 로다주이고 어쩌구저쩌구"),
        MovieInfo(imageName: "spiderman.png", title: "스파이더맨", description: "스파이더맨1 입니다"),
        MovieInfo(imageName: "spiderman2.png", title: "스파이더맨2", description: "톰 홀랜드 굿"),
        MovieInfo(imageName: "thor.png", title: "토르", description: "묠니르를 휘두르는 영화")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        self.navigationItem.title = "영화 목록"
        
        self.view.addSubview(movieListTable)
        movieListTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.cellId) as? MovieTableViewCell
        else {
            return UITableViewCell()
        }
        let cellData = movieList[indexPath.row]
        cell.setupUI(movie: cellData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieData = movieList[indexPath.row]
        let detailVC = MovieDetailViewController(movie: movieData)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
