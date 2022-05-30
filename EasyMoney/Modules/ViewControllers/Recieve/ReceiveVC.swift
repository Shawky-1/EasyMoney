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
    @IBOutlet weak var searchBar: UISearchBar!{
        didSet{
//            searchBar.sizeToFit()
//            searchBar.layer.cornerRadius = 0
//            searchBar.clipsToBounds = true
//            searchBar.placeholder = "Search"
            searchBar.searchTextField.backgroundColor = .clear
        }
    }
    @IBOutlet weak var forTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        viewModel.fetchContacts()
        viewModel.addLeftImageTo(Field: self.forTextField, Image: viewModel.imageText(name: "For") ?? UIImage())
        viewModel.addLeftImageTo(Field: searchBar.searchTextField, Image: viewModel.imageText(name: viewModel.forOrTo()) ?? UIImage())
        print(viewModel.forOrTo())
        print(viewModel.ammount)
        print(UserDefaults.standard.value(forKey: "email") ?? "")
        viewModel.writeTransactionInfo(thisEmail: viewModel.email as! String, otherEmail: "Test2@test.com", transactionAmmount: viewModel.ammount)
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
