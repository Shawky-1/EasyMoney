//
//  LoginVC.swift
//  EasyMoney
//
//  Created by Ahmed Shawky on 04/03/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!{
        didSet{
            emailTextField.text = "test@test.com"
            return
        }
    }
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet{
            passwordTextField.text = "password"
        }
    }
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    let database = Firestore.firestore()
    var userEmail:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(enterNext), for: .editingDidEndOnExit)
        passwordTextField.addTarget(self, action: #selector(enterDone), for: .editingDidEndOnExit)
        addLeftImageTo(Field: emailTextField, Image: UIImage(named: "Mail")!)
        addLeftImageTo(Field: passwordTextField, Image: UIImage(named: "Password")!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.becomeFirstResponder()
    }
    
    
    //MARK: Login button
    @IBAction func didTapLogin(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
                  //MARK: EmptyLogin
                  let alert = createAlert(title: "Incorrect E-mail/Password", Message: "please enter a E-mail and a pasword")
                  alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
                  self.present(alert, animated: true, completion: nil)
                  return
              }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {[weak self]rseult, error in
            guard let strongSelf = self else {return}
            guard error == nil else {
                //MARK: InvalidLogin
                let alert = strongSelf.createAlert(title: "Invalid Email/Password", Message: "Please enter a correct E-mail/Password")
                alert.addAction(UIAlertAction(title: "continue", style: UIAlertAction.Style.default, handler:nil))
//                                strongSelf.showCreateAccount(email: email, password: password)
                return
            }
            //MARK: Sucessful Login
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarVC")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            strongSelf.userEmail = email
            print ("\(email) have singed in")
            UserDefaults.standard.set(email, forKey: "email")
        })
    }
    

    @IBAction func didTapSkip(_ sender: UIButton) {
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        let reciverVC = segue.destination as? RegisterVC
    //        if let text = emailTextField.text{
    //            reciverVC?.emailTextField.text = text
    //        }
    //    }
    
    
    
}


extension LoginVC{
    func addLeftImageTo(Field: UITextField, Image: UIImage){
        let leftImageView = UIImageView(frame: CGRect(x: 5, y: 0, width: Image.size.width, height: Image.size.height))
        leftImageView.image = Image
        Field.leftView = leftImageView
        Field.leftViewMode = .always
    }
    
    func showCreateAccount(email: String, password: String) {
        let alert = createAlert(title: "Create account", Message: "would you like to create an account?")
        alert.addAction(UIAlertAction(title: "Continue",
                                      style: .default))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel))
        present(alert, animated: true)
    }
    
    func createAlert(title: String, Message: String) -> UIAlertController{
        let alert = UIAlertController(title: title, message: Message, preferredStyle: UIAlertController.Style.alert)
        return alert
    }
    
    func navigateToHomeVC() {
        let homeVM = HomeVM(dataManager: DataManager.create())
        let HomeVC = HomeVC.make(from: .main, with: homeVM)
        self.navigationController?.pushViewController(HomeVC, animated: true)
        
    }
    
    func textFieldNext(textField: UITextField) {
        textField.resignFirstResponder()
        if textField.text != nil { // Switch focus to other text field
            passwordTextField.becomeFirstResponder()
        }
    }
    
    func textFiedFinish(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
    
    @objc func enterNext(){
        passwordTextField.becomeFirstResponder()
    }
    
    @objc func enterDone(){
        passwordTextField.resignFirstResponder()
    }
    
}
