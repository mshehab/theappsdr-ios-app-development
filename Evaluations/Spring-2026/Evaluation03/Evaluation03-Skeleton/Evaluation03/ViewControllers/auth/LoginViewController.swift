//
//  LoginViewController.swift
//  Assignment09
//
//  Created by Mohamed Shehab on 3/18/26.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if email.isEmpty || password.isEmpty {
            showAlert(title: "Error", message: "Please fill in all fields.")
        } else if password.count < 6 {
            showAlert(title: "Error", message: "Password must be at least 6 characters long.")
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    self.showAlert(title: "Login Failed", message: error.localizedDescription)
                } else {
                    SceneDelegate.showPolls()
                }
            }
        }
        
    }
    
    @IBAction func createAccountClicked(_ sender: Any) {
        SceneDelegate.showSignUp()
    }
    
}

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
