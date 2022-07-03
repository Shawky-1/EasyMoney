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
        
        let item1 = HomeVC.make(from: .main, with: HomeVM(dataManager: .init(), balance: UserDefaults.standard.double(forKey: "balance")))
        let item2 = TransactionVC.make(from: .main, with: TransactionVM(dataManager: .init()))
        let item3 = SettingsVC.make(from: .main, with: SettingsVM(dataManager: .init()))
        
        let icon1 = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let icon2 = UITabBarItem(title: "Transaction", image: UIImage(named: "Transactions"), selectedImage: UIImage(named: "Transactions-Filled"))
        let icon3 = UITabBarItem(title: "Settings", image: UIImage(named: "Settings"), selectedImage: UIImage(named: "Settings-Filled"))
        
        item1.tabBarItem = icon1
        item2.tabBarItem = icon2
        item3.tabBarItem = icon3
        

        let homeNav = UINavigationController(rootViewController: item1)
        let TransactionsNav = UINavigationController(rootViewController: item2)
        let settingNav = UINavigationController(rootViewController: item3)
        
        
        homeNav.navigationBar.prefersLargeTitles = false
        TransactionsNav.navigationBar.prefersLargeTitles = true
        settingNav.navigationBar.prefersLargeTitles = false


        
        let controllers = [homeNav, TransactionsNav, settingNav]
        tabBar.barStyle = .default
        self.viewControllers = controllers
        
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
