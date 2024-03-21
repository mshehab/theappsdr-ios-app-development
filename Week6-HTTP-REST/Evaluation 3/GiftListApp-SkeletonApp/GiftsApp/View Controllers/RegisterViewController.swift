//
//  RegisterViewController.swift
//  GiftsApp
//
//  Created by Mohamed Shehab on 3/18/24.
//

import UIKit
import SwiftyJSON
import Alamofire
import PKHUD

class RegisterViewController: UIViewController {
    @IBOutlet weak var fnameTextField: UITextField!
    @IBOutlet weak var lnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        let fname = fnameTextField.text!
        let lname = lnameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if fname.isEmpty || lname.isEmpty || email.isEmpty || password.isEmpty {
            print("Enter fname/lnameemail/password !!")
        } else {
            
            let parameters = [
                "email": email,
                "password": password,
                "fname": fname,
                "lname": lname
            ]
            
            HUD.show(.labeledProgress(title: "Register", subtitle: "Please wait!"))
            
            AF.request("https://www.theappsdr.com/api/signup", method: .post, parameters: parameters)
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
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
