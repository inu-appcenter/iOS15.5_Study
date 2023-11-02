//
//  ViewController.swift
//  MusicSearchApp
//
//  Created by 이대현 on 2023/11/01.
//

import UIKit
import SnapKit

enum FetchError: Error {
    case invalidStatus
    case jsonDecodeError
}

final class MusicListViewController: UIViewController {
    private lazy var musicSearchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        return searchController
    }()
    
    private lazy var musicListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        return collectionView
    }()
    
    var musicListDataSource: [MusicData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        configureCollectionView()
        setMusicList()
    }
    
    private func layout() {
        self.navigationItem.title = "Music Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = self.musicSearchController
        
        self.view.addSubview(musicListCollectionView)
        musicListCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureCollectionView() {
        musicListCollectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: MusicCollectionViewCell.identifier)
        musicListCollectionView.delegate = self
        musicListCollectionView.dataSource = self
    }

    private func setMusicList(_ filter: String? = nil) {
        let term: String
        if let filter = filter {
            term = filter
        } else {
            term = "jack+johnson" // default value
        }
        let components = URLComponents(string: "https://itunes.apple.com/search?media=music&term=\(term)")
        guard let url = components?.url else { return }
        
        Task {
            do {
                musicListDataSource = try await fetchMusicList(url: url)
                print(musicListDataSource.count)
                musicListCollectionView.reloadData()
            }
        }
    }
    
    private func fetchMusicList(url: URL) async throws -> [MusicData] {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw FetchError.invalidStatus
        }
        
        guard let musicData = try? JSONDecoder().decode(MusicSearchResponse.self, from: data) else {
            throw FetchError.jsonDecodeError
        }
        return musicData.results
    }
}

extension MusicListViewController:
    UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicListDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MusicCollectionViewCell.identifier,
            for: indexPath
        ) as? MusicCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setupUI(data: musicListDataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width - 0.5
        let height: CGFloat = 150
        return CGSize(width: width, height: height)
    }
}

extension MusicListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
        setMusicList(searchController.searchBar.text)
    }
}
