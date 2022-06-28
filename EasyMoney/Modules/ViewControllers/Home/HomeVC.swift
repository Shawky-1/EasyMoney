//
//  HomeVC.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 14/12/2021.
//

import UIKit
import FirebaseFirestore
import RxSwift

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
    @IBOutlet weak var balanceLbl: UILabel!{
        didSet{
            var balance = UserDefaults.standard.double(forKey: "balance")
            balanceLbl.text = "EGP \(String(balance))"
        }
    }
    
    //MARK: viewWillAppear
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
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        getInfo()
        super.viewDidLoad()
        registerCells()
        viewModel.viewDidLoad()
        setupUI()
    }
    //MARK: signUserOut
    @objc func signUserOut() {
        viewModel.signOut()
        if let controller = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)
        }
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
            .drive(onNext:{ state in
                guard state else {return}
            }).disposed(by: disposeBag)
    }
    
    
}

extension HomeVC {
    //MARK: Essential functions
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
    
    func registerCells(){
        tableView.register(cell: HomeCell.self)
    }
    
    func updateUI() {
        tableView.reloadData()
    }
    
    func setupUI() {
        setUpMenuButton()
    }
    
    
    func getInfo() {
        let database = Firestore.firestore()
        let email = UserDefaults.standard.string(forKey: "email")
        let docRef = database.collection("Users/\(email!)/Data").document("Info")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let balance = document.get("Balance")as? Double ?? 0
                self.balanceLbl.text = "EGP \(String(balance))"
            } else {
                print("Document does not exist", UserDefaults.standard.string(forKey: "email") as Any)
            }
            
        }
    }
}
