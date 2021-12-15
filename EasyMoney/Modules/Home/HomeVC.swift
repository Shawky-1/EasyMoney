//
//  HomeVC.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 14/12/2021.
//

import UIKit

class HomeVC: BaseWireframe<HomeVM> {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        let hasViewedWalkthrough = defaults.bool(forKey: "hasViewedWalkthrough")
        if hasViewedWalkthrough { return }
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "WalkThroughVC") as? WalkThroughVC {
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
        }
    }
    
    override func bind(viewModel: HomeVM) {
        viewModel
            .refreshView
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{[weak self] state in
                guard state else {return}
            }).disposed(by: disposeBag)
    }
    

}
