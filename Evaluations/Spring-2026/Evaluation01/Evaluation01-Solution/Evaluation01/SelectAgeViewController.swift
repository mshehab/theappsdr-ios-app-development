//
//  SelectAgeViewController.swift
//  Evaluation01
//
//  Created by Mohamed Shehab on 2/18/26.
//

import UIKit

class SelectAgeViewController: UIViewController {
    var selectionDelegate: SelectDelegate?
    
    @IBOutlet weak var ageTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        if let age = Int(ageTextField.text ?? "") {
            if let delegate = selectionDelegate {
                delegate.didSelect(age: age)
            }
            dismiss(animated: true)
        } else {
            showAlert(title: "Error", message: "Enter valid age")
        }
    }

}
