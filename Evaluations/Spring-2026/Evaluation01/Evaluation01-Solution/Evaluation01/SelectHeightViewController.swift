//
//  SelectHeightViewController.swift
//  Evaluation01
//
//  Created by Mohamed Shehab on 2/18/26.
//

import UIKit

class SelectHeightViewController: UIViewController {
    var selectionDelegate: SelectDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBOutlet weak var inchesTextfield: UITextField!
    @IBOutlet weak var ftTexfield: UITextField!
    
    @IBAction func submitClicked(_ sender: Any) {
        if let ft = Double(ftTexfield.text ?? "") {
            if let inches = Double(inchesTextfield.text ?? "") {
                if let delegate = selectionDelegate {
                    delegate.didSelect(heightFt: ft, heightIn: inches)
                }
                dismiss(animated: true)
            } else {
                showAlert(title: "Error", message: "Enter valid height (inches)")
            }
        } else {
            showAlert(title: "Error", message: "Enter valid height (ft)")
        }
            
        
        
        
    }
    
}
