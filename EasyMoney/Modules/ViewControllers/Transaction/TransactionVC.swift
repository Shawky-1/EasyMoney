//
//  TransactionVC.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 06/03/2022.
//

import UIKit

class TransactionVC: BaseWireframe<TransactionVM>{
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.dataSource = TransactionDatasrc
            collectionView.delegate = TransactionDatasrc
        }
    }
    @IBOutlet weak var transactionAmmountLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var receiveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        
    }
    var totalAmmount = 0
    
    override func bind(viewModel: TransactionVM) {
        viewModel
            .refreshView
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{[weak self] state in
                guard state else {return}
            }).disposed(by: disposeBag)
    }
    
    private lazy var TransactionDatasrc: TransactionDatasrc = {
        let src = EasyMoney.TransactionDatasrc()
        src.viewModel = viewModel
        
        src.onNumberSelected = { [weak self] text in
            guard let self = self else {return}
            self.updateTransactionLabel(text: text)
        }
        
        src.onDelString = { [weak self] text in
            guard let self = self else {return}
            self.transactionAmmountLabel.text = self.deleteLastInput(text: self.transactionAmmountLabel.text!)
        }
        
        return src
    }()
    //MARK: Recieve/Send button
    @IBAction func didTapReceive(_ sender: UIButton) {
        viewModel.setReceiverData(data: "From")
        navigateToReceive(transactionAmmount: totalAmmount)
        
    }
    @IBAction func didTapSend(_ sender: UIButton) {
        viewModel.setReceiverData(data: "To")
        navigateToReceive(transactionAmmount: totalAmmount)
    }
    
}

extension TransactionVC {
    
    func registerCells(){
        collectionView.register(TransactionsNumPad.self, forCellWithReuseIdentifier: "TransactionsNumPad")
    }
    
    func shakeThisView(){
        view.shakeScreen()
    }
    
    func updateTransactionLabel(text: String){
        //        transactionAmmountLabel.text? += text
        switch transactionAmmountLabel.text?.filter({ $0 == "." }).count {
        case 0:
            if transactionAmmountLabel.text == "" && text == "." {
                transactionAmmountLabel.text? += "0"
                transactionAmmountLabel.text? += text
            }
            else{
                transactionAmmountLabel.text? += text
            }
        case 1:
            if (text == "."){
                shakeThisView()
                
            }
            else {
//                if transactionAmmountLabel.text?.filter({$0 == "."})
                transactionAmmountLabel.text? += text
                
            }
        default:
            return
        }
        totalAmmount = (transactionAmmountLabel.text! as NSString).integerValue
        
    }
    
    func deleteLastInput(text: String) -> String {
        
        var inputText: String = transactionAmmountLabel.text ?? ""
        if (!(inputText.isEmpty)){
        inputText.remove(at: inputText.index(before: inputText.endIndex))
        }
        else {
            shakeThisView()
        }
        
        return inputText
        
    }
}


extension TransactionVC {
    func navigateToReceive(transactionAmmount: Int){
        let ReceiveVM = EasyMoney.ReceiveVM(dataManager: DataManager.create(), ammount: (transactionAmmountLabel.text! as NSString).doubleValue, receiver: viewModel.getReceiverData())
        let ReceiveVC = ReceiveVC.make(from: .main, with: ReceiveVM)
        ReceiveVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(ReceiveVC, animated: true)
    }
}
