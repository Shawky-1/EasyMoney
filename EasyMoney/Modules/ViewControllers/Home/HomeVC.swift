//
//  HomeVC.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 14/12/2021.
//

import UIKit
import FirebaseFirestore

class HomeVC: BaseWireframe<HomeVM> {
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = HomeDataSrc
            tableView.dataSource = HomeDataSrc
            tableView.tableFooterView = UIView()
            tableView.frame = .zero
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = HomeDataSrc
            collectionView.dataSource = HomeDataSrc
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        viewModel.viewDidLoad()
        setupUI()

    }
    
//    private lazy var signOutButton: UIBarButtonItem = {
//        var button = UIBarButtonItem(image: UIImage(named: "Logout"), style: .plain, target: self, action: #selector(signUserOut))
//
//        return button
//    }()
    
    func setUpMenuButton(){
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuBtn.setImage(UIImage(named:"Logout"), for: .normal)
        menuBtn.addTarget(self, action: #selector(signUserOut), for: UIControl.Event.touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight?.isActive = true
        self.navigationItem.rightBarButtonItem = menuBarItem
    }
    
    @objc func signUserOut() {
        viewModel.signOut()
        if let controller = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        let hasViewedWalkthrough = defaults.bool(forKey: "hasViewedWalkthrough")
        if hasViewedWalkthrough { return }
        
        if let controller = mainStoryboard.instantiateViewController(withIdentifier: "WalkThroughVC") as? WalkThroughVC {
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
        }
    }
    
    
    func registerCells(){
        tableView.register(cell: HomeCell.self)
        collectionView.register(cell: CardColelctionViewCell.self)
    }
    
    func updateUI() {
        tableView.reloadData()
    }
    
    func setupUI() {
        setUpMenuButton()
    }
    
    private lazy var HomeDataSrc: HomeDataSrc = {
        let src = EasyMoney.HomeDataSrc()
        src.viewModel = viewModel
        return src
    }()
    
    
    
    override func bind(viewModel: HomeVM) {
        viewModel
            .refreshView
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{[weak self] state in
                guard state else {return}
            }).disposed(by: disposeBag)
    }
    

}
