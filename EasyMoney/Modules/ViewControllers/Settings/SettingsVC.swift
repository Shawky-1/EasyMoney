//
//  SettingsVC.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 26/02/2022.
//

import UIKit

class SettingsVC: BaseWireframe<SettingsVM> {
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = SettingsDataSrc
            tableView.delegate = SettingsDataSrc
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()

    }
    
    
    func registerCells(){
        tableView.register(cell: SettingsCell.self)
    }
    
    
    private lazy var SettingsDataSrc: SettingsDataSrc = {
        let src = EasyMoney.SettingsDataSrc()
        src.viewModel = viewModel
        return src
    }()
    
    override func bind(viewModel: SettingsVM) {
        viewModel
            .refreshView
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{[weak self] state in
                guard state else {return}
            }).disposed(by: disposeBag)
    }

}
