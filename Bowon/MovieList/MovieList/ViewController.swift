//
//  ViewController.swift
//  MovieList
//
//  Created by Bowon Han on 10/5/23.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    lazy var dataList : [Section] = {
        var datalist = [Section]()
        for i in 0..<10 {
            let list = Section()
            list.movieImg = UIImage(named: list.imgName[i])
            list.movieTitle = list.title[i]
            list.moviePlot = list.plot[i]
            datalist.append(list)
        }
        return datalist
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        myTableView.dataSource = self
        myTableView.delegate = self
        
        setConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationButton()
    }
    
    
    private let myTableView:UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    //barButtonItem
    private func setNavigationButton(){
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.title = "영화 목록"
    }

    //constraint
    private func setConstraint(){
        myTableView.register(ListViewCell.self, forCellReuseIdentifier: ListViewCell.identifier)

        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.estimatedRowHeight = UITableView.automaticDimension
        
        
        self.view.addSubview(myTableView)
        myTableView.translatesAutoresizingMaskIntoConstraints = false
                
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            myTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            myTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            myTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            myTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    
    
// MARK: - table View data source
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = dataList[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListViewCell.identifier, for: indexPath) as? ListViewCell else { return UITableViewCell() }
        
        cell.movieTitle.text = row.movieTitle
        cell.movieImg.image = row.movieImg
        cell.moviePlot.text = row.moviePlot

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = dataList[indexPath.row]
        let detailVC = DetailViewController()
        
        detailVC.receiveImg = row.movieImg
        detailVC.receiveTitle = row.movieTitle
        detailVC.receivePlot = row.moviePlot
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}


