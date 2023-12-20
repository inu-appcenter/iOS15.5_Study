//
//  MainTabBarController.swift
//  ToDoListApp
//
//  Created by 이대현 on 2023/11/08.
//

import UIKit

class MainTabBarController: UITabBarController {
    let taskVC = UINavigationController(rootViewController: TaskViewController())
    let settingVC = SettingViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        layout()
    }
    
    private func setupVC() {
        let taskTabBarItem = UITabBarItem(title: "Tasks", image: UIImage(systemName: "checkmark.circle.fill"), tag: 0)
        let settingTabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 0)
        taskVC.tabBarItem = taskTabBarItem
        settingVC.tabBarItem = settingTabBarItem
        setViewControllers([taskVC, settingVC], animated: false)
    }
    
    private func layout() {
        self.tabBar.tintColor = .red
    }
}
