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
            searchBar.searchTextField.backgroundColor = .clear
            searchBar.delegate = ReceiveDataSrc
            searchBar.searchTextField.delegate = self


        }
    }
    @IBOutlet weak var forTextField: UITextField!{
        didSet{
            forTextField.delegate = self
        }
    }
    @IBOutlet weak var continueBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.addLeftImageTo(Field: self.forTextField, Image: viewModel.imageText(name: "For") ?? UIImage())
        viewModel.addLeftImageTo(Field: searchBar.searchTextField, Image: viewModel.imageText(name: viewModel.receiver) ?? UIImage())
        
    }
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.changeTitle()
        registerCells()
        viewModel.fetchContacts()
    }
    
    func registerCells(){
        contactsTableView.register(cell: ReceiveCell.self)
    }
    //MARK: ReceiveDataSrc
    private lazy var ReceiveDataSrc: ReceiveVCDataSrc = {
        let src = EasyMoney.ReceiveVCDataSrc()
        src.viewModel = viewModel
        src.onItemSelected = { [weak self] selectedContact in
            guard let self = self else {return}
            self.viewModel.selectedContact = selectedContact
            self.selectName(name: selectedContact.firstName)
            self.continueBtn.isHidden = false
        }
        src.onReloadData = { [weak self] in
            guard let self = self else {return}
            self.contactsTableView.reloadData()
            
        }
        
        src.onContinueShow = { [weak self] in
            guard let self = self else {return}
            self.continueBtn.isHidden = true
            
        }
        return src
    }()
    //MARK: Bind function
    override func bind(viewModel: ReceiveVM) {
        viewModel
            .refreshView
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{state in
                guard state else {return}
            }).disposed(by: disposeBag)
    }
    @IBAction func clickContinue(_ sender: UIButton) {
        navigateToConfirmVM(transactionAmmount: Double(viewModel.ammount))
    }
    
}

//MARK: Extention Function
extension ReceiveVC {
    
    func selectName(name: String){
        searchBar.searchTextField.text = name
    }
    
    func navigateToConfirmVM(transactionAmmount: Double) {
        let confirmVM = ConfirmVM(dataManager: DataManager.create(),
                                  transactionAmmount: transactionAmmount,
                                  contact: viewModel.selectedContact!,
                                  send: viewModel.send)
        let confirmVC = ConfirmVC.make(from: .main, with: confirmVM)
        confirmVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(confirmVC, animated: true)
        
    }

}

extension ReceiveVC {
    
    @objc func enterDone(textField: UITextField){
        textField.resignFirstResponder()
    }
}

extension ReceiveVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
}
