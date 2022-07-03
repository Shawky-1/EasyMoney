//
//  TransactionVC.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 02/07/2022.
//

import Foundation
import UIKit

class TransactionDetailsVC: BaseWireframe<TransactionDetailsVM> {
    @IBOutlet weak var transactionIDLbl: UILabel!
    @IBOutlet weak var transferedFromLbl: UILabel!
    @IBOutlet weak var transferedToLbl: UILabel!
    @IBOutlet weak var transactionDateLbl: UILabel!
    @IBOutlet weak var transactionAmmountLbl: UILabel!
    @IBOutlet weak var transactionImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupLabels(transactionIDLbl: transactionIDLbl, transferedFromLbl: transferedFromLbl, transferedToLbl: transferedToLbl, transactionDateLbl: transactionDateLbl, transactionAmmountLbl: transactionAmmountLbl)
        transactionImage.image = viewModel.imageWith(name: viewModel.transaction.transferedTo)
    }
    
    override func bind(viewModel: TransactionDetailsVM) {
        viewModel
            .refreshView
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{ state in
                guard state else {return}
            }).disposed(by: disposeBag)
    }

}
