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

        // Do any additional setup after loading the view.
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
