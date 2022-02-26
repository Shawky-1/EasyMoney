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
//        self.delegate = self
        
        let item1 = HomeVC.make(from: .main, with: HomeVM(dataManager: .init()))
        let item2 = HomeVC.make(from: .main, with: HomeVM(dataManager: .init()))
        let item3 = SettingsVC.make(from: .main, with: SettingsVM(dataManager: .init()))
        
        let icon1 = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let icon2 = UITabBarItem(title: "", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let icon3 = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "Settings"), selectedImage: #imageLiteral(resourceName: "Settings-Fill"))
        
        item1.tabBarItem = icon1
//        item1.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -100)
        item2.tabBarItem = icon2
        item3.tabBarItem = icon3
        

        let homeNav = UINavigationController(rootViewController: item1)
        let settingNav = UINavigationController(rootViewController: item3)
        let testNav = UINavigationController(rootViewController: item2)
        
//        homeNav.tabBarItem.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: -5, right: 0)
//        homeNav.tabBarItem.title = "Test"
//        homeNav.tabBarItem.badgeColor = UIColor(red: 20, green: 20, blue: 02)
        
        let controllers = [homeNav, testNav, settingNav]
        tabBar.barStyle = .default
        self.viewControllers = controllers
        
    }
    
}

//extension MainTabBarVC:UITabBarControllerDelegate{
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
//            return false // Make sure you want this as false
//        }
//
//        if fromView != toView {
//            UIView.transition(from: fromView, to: toView, duration: 0.25, options: [.transitionCrossDissolve], completion: nil)
//        }
//
//        return true
//    }
//}
