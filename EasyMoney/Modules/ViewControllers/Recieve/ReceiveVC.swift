//
//  RecieveVC.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 09/05/2022.
//

import UIKit

class ReceiveVC: BaseWireframe<ReceiveVM> {

    @IBOutlet weak var contactsTableView: UITableView!{
        didSet{
            contactsTableView.delegate = ReceiveDataSrc
            contactsTableView.dataSource = ReceiveDataSrc
            contactsTableView.tableFooterView = UIView()
            contactsTableView.frame = .zero
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        viewModel.fetchContacts()

    }
    
    
    func registerCells(){
        contactsTableView.register(cell: ReceiveCell.self)
    }
    
    
    private lazy var ReceiveDataSrc: ReceiveVCDataSrc = {
        let src = EasyMoney.ReceiveVCDataSrc()
        src.viewModel = viewModel
        return src
    }()
    
    override func bind(viewModel: ReceiveVM) {
        viewModel
            .refreshView
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{[weak self] state in
                guard state else {return}
            }).disposed(by: disposeBag)
    }

}

extension ReceiveVC {

}
