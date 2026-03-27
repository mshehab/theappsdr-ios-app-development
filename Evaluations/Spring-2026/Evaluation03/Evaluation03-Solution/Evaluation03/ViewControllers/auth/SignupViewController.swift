//
//  SignupViewController.swift
//  Assignment09
//
//  Created by Mohamed Shehab on 3/18/26.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if name.isEmpty || email.isEmpty || password.isEmpty {
            showAlert(title: "Error", message: "Please fill in all fields.")
        } else if password.count < 6 {
            showAlert(title: "Error", message: "Password must be at least 6 characters long.")
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    self.showAlert(title: "Signup Failed", message: error.localizedDescription)
                } else {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = name
                    changeRequest?.commitChanges { error in
                        if let error = error {
                            print("Failed to set display name: \(error.localizedDescription)")
                        } else {
                            SceneDelegate.showPolls()
                        }
                    }
                }
            }
        }
        
        
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        SceneDelegate.showLogin()
    }

}
