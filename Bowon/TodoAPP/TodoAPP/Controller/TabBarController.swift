//
//  TabBarController.swift
//  todoAPP
//
//  Created by Bowon Han on 11/9/23.
//

import UIKit

class TabBarController : UITabBarController {
    let todoListVC = UINavigationController(rootViewController: TodoListViewController())
    let settingVC = UINavigationController(rootViewController: SettingViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        layout()
    }
    
    @objc func tapManageSectionButton(_:UIBarButtonItem) {
        let manageSectionVC = ManageSectionViewController()
        todoListVC.pushViewController(manageSectionVC, animated: true)
        manageSectionVC.navigationController?.navigationBar.tintColor = .darkGreen
    }
    
    private func setupVC() {
        todoListVC.navigationBar.topItem?.titleView = NavigationBarTitleView(vcName: "To do")
        settingVC.navigationBar.topItem?.titleView = NavigationBarTitleView(vcName: "Setting")

        let setButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle.fill"), style:.plain, target: nil, action: #selector(tapManageSectionButton))
        
        todoListVC.navigationBar.topItem?.rightBarButtonItem = setButton
        todoListVC.navigationBar.topItem?.rightBarButtonItem?.tintColor = .black
        
        let todoListTabBarItem = UITabBarItem(title: "Tasks", image: UIImage(systemName: "checkmark.circle.fill"), tag: 0)
        let settingTabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 0)

        todoListVC.tabBarItem = todoListTabBarItem
        settingVC.tabBarItem = settingTabBarItem

        setViewControllers([todoListVC,settingVC], animated: true)
    }
    
    private func layout() {
        self.tabBar.backgroundColor = .systemGray5
        self.tabBar.tintColor = .darkYellow
    }
}
