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
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var createAccountButton: UIButton!
    
    
    
    
    
    
    
    let database = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    
    //MARK: CreateButtonClicked
    @IBAction func clickedCreateButton(_ sender: UIButton) {
        emailLabel.text = ""
        passwordLabel.text = ""
        confirmPasswordLabel.text = ""
        
        guard let email = emailTextField.text, !email.isEmpty else {
            emailLabel.text = "PLease enter a valid Email"
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            passwordLabel.text = "PLease enter a password"
            passwordTextField.text = ""
            return
        }
        
        guard let password = passwordTextField.text,
              let confirmpassword = confirmPasswordTextField.text, password == confirmpassword else{
                  confirmPasswordLabel.text = "Password Doesn't match"
                  passwordTextField.text = ""
                  confirmPasswordTextField.text = ""
                  return
              }
        writeData(firstName: firstName.text!, lastName: lastName.text!, email: emailTextField.text!, birthDate: datePicker.date)
        createUserData(firstName: firstName.text!, lastName: lastName.text!, email: emailTextField.text!, birthDate: datePicker.date)
        
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
    
    
}

extension RegisterVC{
    func writeData(firstName: String, lastName:String, email:String, birthDate:Date){
        database.collection("Users/\(String(email))/Data").document("Info").setData([
            "Email":email,
            "FirstName": firstName,
            "LastName": lastName,
            "BirthDate": birthDate
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func createUserData(firstName: String, lastName:String, email:String, birthDate:Date){
        let defaults = UserDefaults.standard
        defaults.set(firstName, forKey: "firstName")
        defaults.set(lastName, forKey: "lastName")
        defaults.set(email, forKey: "email")
        defaults.set(birthDate, forKey: "birthDate")
    }
    
    
}
