//
//  ConfirmVC.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 25/06/2022.
//

import Foundation
import UIKit
import Firebase

class ConfirmVC: BaseWireframe<ConfirmVM> {
    
    @IBOutlet weak var profilePicture: UIImageView!{
        didSet{
            profilePicture.image = viewModel.imageWith(name: viewModel.contact.firstName + " " + viewModel.contact.lastName)
        }
    }
    @IBOutlet weak var transactionDetails: UILabel!
    @IBOutlet weak var transactionAmmount: UILabel!{
        didSet{
            transactionAmmount.text = String(viewModel.transactionAmmount)
        }
    }
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupTextLabel(Label: transactionDetails)

    }
    
    override func bind(viewModel: ConfirmVM) {
        viewModel
            .refreshView
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{ state in
                guard state else {return}
            }).disposed(by: disposeBag)
        
        viewModel.onPopVC = { [weak self] in
            guard let self = self else {return}
            let alert = UIAlertController(title: "Transaction sucessfully made!", message: "Press continue to go back", preferredStyle: UIAlertController.Style.alert)
            let continueAction = UIAlertAction(title: "Continue", style: .default) { (action) in
                UserDefaults.standard.set(viewModel.currentUpdatedBalance, forKey: "balance")
                self.navigationController?.popToRootViewController(animated: true)
            }
            alert.addAction(continueAction)
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func didClickConfirm(_ sender: UIButton) {
            viewModel.getData()
    }
}

