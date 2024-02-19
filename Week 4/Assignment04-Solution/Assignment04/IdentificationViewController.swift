//
//  IdentificationViewController.swift
//  Assignment04
//
//  Created by Mohamed Shehab on 2/5/24.
//

import UIKit

class IdentificationViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var roleSegmentedControl: UISegmentedControl!
    var response:Response?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoDemographicSegue"{
            let vc = segue.destination as! DemographicViewController
            vc.response = self.response
        }
    }
    
    
    @IBAction func onNextClicked(_ sender: Any) {
        let name = nameTextField.text!
        let email = emailTextField.text!
        var role = "Student"
        
        if roleSegmentedControl.selectedSegmentIndex == 1 {
            role = "Employee"
        } else if roleSegmentedControl.selectedSegmentIndex == 2 {
            role = "Other"
        }
        
        
        if name.isEmpty {
            showErrorMessage(title: "ID Error", message: "Enter valid name")
        } else if email.isEmpty {
            showErrorMessage(title: "ID Error", message: "Enter valid email")
        } else {
            response = Response(name: name, email: email, role: role)
            performSegue(withIdentifier: "gotoDemographicSegue", sender: self)
        }
    }
    
}

extension UIViewController {
    func showErrorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
}

