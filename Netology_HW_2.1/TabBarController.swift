//
//  TabBarController.swift
//  Netology_HW_2.1
//
//  Created by Dima Gorbachev on 13.04.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstTab = DocumentsViewController()
        let tabOneBarItem = UITabBarItem(title: "Документы", image: UIImage(systemName: "folder"), selectedImage: UIImage(systemName: "folder"))
        firstTab.tabBarItem = tabOneBarItem
        
        let secondTab = SettingsViewController()
        let tabTwoBarItem = UITabBarItem(title: "Настройки", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"))
        secondTab.tabBarItem = tabTwoBarItem
        
        self.viewControllers = [firstTab, secondTab]
    }
}
