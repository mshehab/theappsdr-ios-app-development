//
//  LoginViewController.swift
//  Assignment08
//
//  Created by Mohamed Shehab on 3/13/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked(_ sender: Any) {
     
        //on successful login call
        //SceneDelegate.showPosts()
        
    }
}


extension UIViewController {
    
    func showAlertWith(title: String, message: String, okAlertAction: ((UIAlertAction) -> Void)?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: okAlertAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
 
    func showAlertWith(title: String, message: String, okAlertAction: ((UIAlertAction) -> Void)?, cancelAlertAction: ((UIAlertAction) -> Void)?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: okAlertAction)
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: cancelAlertAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWith(title: String, message: String, deleteAlertAction: ((UIAlertAction) -> Void)?, cancelAlertAction: ((UIAlertAction) -> Void)?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: deleteAlertAction)
        alertController.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: cancelAlertAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
