//
//  TabBarController.swift
//  TodoAPP_project
//
//  Created by Bowon Han on 11/26/23.
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
    
    private func setupVC() {
        todoListVC.navigationBar.topItem?.titleView = NavigationBarTitleView(vcName: "To do")
        settingVC.navigationBar.topItem?.titleView = NavigationBarTitleView(vcName: "Setting")
                
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
