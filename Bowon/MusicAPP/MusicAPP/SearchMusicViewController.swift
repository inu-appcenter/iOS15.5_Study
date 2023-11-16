//
//  SearchMusicViewController.swift
//  MusicAPP
//
//  Created by Bowon Han on 11/1/23.
//

import UIKit
import SnapKit

enum FetchError: Error {
    case invalidStatus
    case jsonDecodeError
}

class SearchMusicViewController : UIViewController {
    var musicInfo : [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        configure()
        requestURL()
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1.0
        layout.minimumLineSpacing = 1.0
               
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: MusicCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        
        return searchBar
    }()
    
    func configure(){
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self

    }
    
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
    private func requestURL(_ filter: String? = nil) {
        let id: String
        if let filter = filter {
            id = filter
        } else {
            id = "new jeans" // default value
        }
        
        guard let url = URL(string: "https://itunes.apple.com/search?media=music&term=\(id)") else { return }
        
        Task {
            do {
                let musicInformation = try await self.fetchMusicInfo(url: url)
                self.musicInfo = musicInformation
                DispatchQueue.main.async{
                    self.collectionView.reloadData()
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    private func fetchMusicInfo(url: URL) async throws -> [Music] {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 else {
                throw FetchError.invalidStatus
            }
        
        let musicInformation = try JSONDecoder().decode(MusicService.self, from: data)
        return musicInformation.results
    }
}

// MARK: - extension
extension SearchMusicViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MusicCollectionViewCell.identifier,
            for: indexPath
        ) as? MusicCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.requestImageURL(data: musicInfo[indexPath.row])
        
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
        requestURL(searchText)
    }
}
