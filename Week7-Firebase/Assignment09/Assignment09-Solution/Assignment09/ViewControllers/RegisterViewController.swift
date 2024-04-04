//
//  RegisterViewController.swift
//  Assignment08
//
//  Created by Mohamed Shehab on 3/13/24.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var fullnameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        let name = fullnameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if name.isEmpty || email.isEmpty || password.isEmpty {
            showAlertWith(title: "Register Error", message: "Please enter valid name/email/password", okAlertAction: nil)
        } else {
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                
                if error == nil {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = name
                    changeRequest?.commitChanges(completion: { error in
                        if let error = error {
                            self.showAlertWith(title: "Registration Error", message: error.localizedDescription, okAlertAction: nil)
                        } else {
                            SceneDelegate.showPosts()
                        }
                    })
                } else {
                    self.showAlertWith(title: "Registration Error", message: error!.localizedDescription, okAlertAction: nil)
                }
                
            }
            
        }
        
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
