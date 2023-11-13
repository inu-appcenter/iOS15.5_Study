//
//  MainTabBarController.swift
//  ToDoListApp
//
//  Created by 이대현 on 2023/11/08.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        layout()
    }
    
    private func setupVC() {
        let taskVC = TaskViewController()
        let settingVC = SettingViewController()
        let taskTabBarItem = UITabBarItem(title: "Tasks", image: UIImage(systemName: "checkmark.circle.fill"), tag: 0)
        let settingTabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 0)
        taskVC.tabBarItem = taskTabBarItem
        settingVC.tabBarItem = settingTabBarItem
        setViewControllers([taskVC, settingVC], animated: false)
    }
    
    private func layout() {
        self.tabBar.tintColor = .red
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
