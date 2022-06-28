//
//  ConfirmVC.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 25/06/2022.
//

import Foundation
import UIKit

class ConfirmVC: BaseWireframe<ConfirmVM> {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var transactionDetails: UILabel!{
        didSet{
            transactionDetails.text = viewModel.contact.firstName
        }
    }
    @IBOutlet weak var transactionAmmount: UILabel!{
        didSet{
            transactionAmmount.text = String(viewModel.transactionAmmount)
        }
    }
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func bind(viewModel: ConfirmVM) {
        viewModel
            .refreshView
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{ state in
                guard state else {return}
            }).disposed(by: disposeBag)
    }
    
    @IBAction func didClickConfirm(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
}

extension ConfirmVC {

    
}
