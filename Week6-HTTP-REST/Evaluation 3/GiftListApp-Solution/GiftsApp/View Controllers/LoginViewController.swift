//
//  LoginViewController.swift
//  GiftsApp
//
//  Created by Mohamed Shehab on 3/18/24.
//

import UIKit
import Alamofire
import SwiftyJSON
import PKHUD

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.text = "a@a.com"
        self.passwordTextField.text = "test123"
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if email.isEmpty || password.isEmpty {
            print("Enter email/password !!")
        } else {
            
            let parameters = [
                "email": email,
                "password": password
            ]
            
            HUD.show(.labeledProgress(title: "Login", subtitle: "Please wait!"))
            
            AF.request("https://www.theappsdr.com/api/login", method: .post, parameters: parameters)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    HUD.hide()
                    switch response.result {
                    case .success:
                        print("Validation Successful")
                        if let data = response.data{
                            if let json = try? JSON(data: data){
                                SceneDelegate.saveToken(token: json["token"].stringValue)
                                SceneDelegate.showGiftLists()
                            }
                        }
                    case let .failure(error):
                        print(error)
                    }
                }
            
        }
        
    }
    
}
