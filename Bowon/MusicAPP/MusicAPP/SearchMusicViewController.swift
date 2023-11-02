//
//  SearchMusicViewController.swift
//  MusicAPP
//
//  Created by Bowon Han on 11/1/23.
//

import UIKit
import SnapKit

class SearchMusicViewController : UIViewController {
    var musicInfo : [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupLayout()
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1.0
        layout.minimumLineSpacing = 1.0
               
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .gray
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: "MusicCollectionViewCell")

        return collectionView
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        
        return searchBar
    }()
    
    func setupLayout() {
        view.addSubview(collectionView)
        view.addSubview(searchBar)
                
        searchBar.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar).offset(50)
            make.bottom.trailing.leading.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
// MARK: - network
    // 네트워크에서 음악 정보를 가져오는 함수
    func requestURL(for id: String) {
        guard let url = URL(string: "https://itunes.apple.com/search?media=music&term=\(id)") else { return }
        
        Task {
            musicInfo = try await self.fetchMusicInfo(url: url)
            collectionView.reloadData()
        }
    }
    
    func fetchMusicInfo(url: URL) async throws -> [Music] {
        let (data, _ ) = try await URLSession.shared.data(from: url)
        let musicInfo = try JSONDecoder().decode(MusicService.self, from: data)
        return musicInfo.results
    }
}

// MARK: - extension
extension SearchMusicViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MusicCollectionViewCell.identifier,
            for: indexPath
        ) as? MusicCollectionViewCell else {
            return UICollectionViewCell()
        }
    
        cell.backgroundColor = .lightGray
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicInfo.count
    }
}

extension SearchMusicViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width / 3) - 1.0
        return CGSize(width: width, height: width)
    }
}

extension SearchMusicViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        requestURL(for: searchText)
    }
}
