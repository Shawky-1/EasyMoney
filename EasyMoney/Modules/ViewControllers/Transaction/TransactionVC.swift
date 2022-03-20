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
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()

    }
    
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
        return src
    }()
    
    
}

extension TransactionVC {
    
    func registerCells(){
        collectionView.register(TransactionsNumPad.self, forCellWithReuseIdentifier: "TransactionsNumPad")
        collectionView.register(DialedNumbersHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
    }
    
    func shakeThisView(){
        view.shakeScreen()
    }

}
