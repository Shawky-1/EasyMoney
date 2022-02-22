//
//  HomeVC.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 14/12/2021.
//

import UIKit

class HomeVC: BaseWireframe<HomeVM> {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = HomeDataSrc
            tableView.dataSource = HomeDataSrc
            tableView.tableFooterView = UIView()

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
    
    
    func registerCells(){
        tableView.register(cell: HomeCell.self)
        collectionView.register(cell: CardColelctionViewCell.self)
    }
    
    func updateUI() {
        tableView.reloadData()
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
