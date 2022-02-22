//
//  MainTabBarVC.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 15/12/2021.
//

import UIKit

class MainTabBarVC: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let item1 = HomeVC.make(from: .main, with: HomeVM(dataManager: .init()))
        let item2 = HomeVC.make(from: .main, with: HomeVM(dataManager: .init()))
        let item3 = HomeVC.make(from: .main, with: HomeVM(dataManager: .init()))
        
        let icon1 = UITabBarItem(title: "", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let icon2 = UITabBarItem(title: "", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let icon3 = UITabBarItem(title: "", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        item1.tabBarItem = icon1
        item2.tabBarItem = icon2
        item3.tabBarItem = icon3
        
        let homeNav = UINavigationController(rootViewController: item1)
        let settingNav = UINavigationController(rootViewController: item2)
        let testNav = UINavigationController(rootViewController: item3)
        
        
        let controllers = [homeNav, testNav, settingNav]
        self.viewControllers = controllers
        
        
    }
    
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        // - 40 is editable , the default value is 49 px, below lowers the tabbar and above increases the tab bar size
        tabFrame.size.height = 40
        tabFrame.origin.y = self.view.frame.size.height - 40
        self.tabBar.frame = tabFrame
    }
    
}

extension MainTabBarVC:UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false // Make sure you want this as false
        }
        
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.25, options: [.transitionCrossDissolve], completion: nil)
        }
        
        return true
    }
}
