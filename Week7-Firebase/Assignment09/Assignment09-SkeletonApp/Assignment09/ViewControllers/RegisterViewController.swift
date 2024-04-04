//
//  RegisterViewController.swift
//  Assignment08
//
//  Created by Mohamed Shehab on 3/13/24.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var fullnameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        //on successful registration call
        //SceneDelegate.showPosts()
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
