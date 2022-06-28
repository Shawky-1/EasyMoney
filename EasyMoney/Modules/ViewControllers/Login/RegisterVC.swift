//
//  RegisterVC.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 05/03/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Alamofire

class RegisterVC: UIViewController {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var phoneNumberTxtF: UITextField!
    
    let database = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: CreateButtonClicked
    @IBAction func clickedCreateButton(_ sender: UIButton) {
        
        do{
            let firstName = try firstName.validatedText(validationType: .name)
            let lastName = try lastName.validatedText(validationType: .name)
            let email = try emailTextField.validatedText(validationType: .email)
            let password = try passwordTextField.validatedText(validationType: .password)
            _ = try confirmPasswordTextField.validatedText(validationType: .passwordMatches(confirmFiled: passwordTextField))
            let phoneNumber = try phoneNumberTxtF.validatedText(validationType: .phone)
            
            createAccount(email: email, password: password)
            saveData(firstName: firstName, lastName: lastName, email: email, birthDate: datePicker.date, phoneNumber: Int(phoneNumber)!)
            
        } catch let error {
            if let error = error as? ValidationErorr {
                NotifiyMessage.shared.toast(toastMessage: error.localizedDescription)
            }
        }
    }
}

extension RegisterVC{
    
    func createAccount(email: String, password: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
            guard error == nil else {
                //show account creation
                print("account creation failed")
                let alert = UIAlertController(title: "Sign-up Failed", message: "Press continue to go back", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Continue", style: .default))
                return
            }
            print ("you have singed in")
            let alert = UIAlertController(title: "Sucessfully Logged in!", message: "Press continue to go back", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .default))
            self.present(alert, animated: true)
            self.navigationController?.popViewController(animated: true)
            
        })
    }
    
    
    
    func saveData(firstName: String, lastName:String, email:String, birthDate:Date, phoneNumber: Int){
        let balance:Double = 0
        let defaults = UserDefaults.standard
        database.collection("Users/\(email)/Data").document("Info").setData([
            "Email":email,
            "FirstName": firstName,
            "LastName": lastName,
            "BirthDate": birthDate,
            "Balance": balance,
            "PhoneNumber": phoneNumber
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        defaults.set(firstName, forKey: "firstName")
        defaults.set(lastName, forKey: "lastName")
        defaults.set(email, forKey: "email")
        defaults.set(birthDate, forKey: "birthDate")
        defaults.set(balance, forKey: "balance")
        defaults.set(phoneNumber, forKey: "phoneNumber")
    }
    
}
