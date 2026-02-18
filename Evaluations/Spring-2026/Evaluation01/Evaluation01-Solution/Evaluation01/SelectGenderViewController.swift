//
//  SelectGenderViewController.swift
//  Evaluation01
//
//  Created by Mohamed Shehab on 2/18/26.
//

import UIKit

class SelectGenderViewController: UIViewController {
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    var selectionDelegate: SelectDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func submitClicked(_ sender: Any) {
        var gender: String = "Female"
        if genderSegmentedControl.selectedSegmentIndex == 1 {
            gender = "Male"
        }
        
        if let delegate = selectionDelegate {
            delegate.didSelect(gender: gender)
        }
        dismiss(animated: true)
    }
}
