//
//  SelectWeightViewController.swift
//  Evaluation01
//
//  Created by Mohamed Shehab on 2/18/26.
//

import UIKit

class SelectWeightViewController: UIViewController {
    var selectionDelegate: SelectDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func submitClicked(_ sender: Any) {
        if let weight = Double(weightTextField.text ?? "") {
            if let delegate = selectionDelegate {
                delegate.didSelect(weight: weight)
            }
            dismiss(animated: true)
        } else {
            showAlert(title: "Error", message: "Enter valid weight")
        }
        
    }
}


extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}
