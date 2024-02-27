//
//  SelectMaritalStatusViewController.swift
//  Assignment04
//
//  Created by Mohamed Shehab on 2/5/24.
//

import UIKit

class SelectMaritalStatusViewController: UIViewController {

    @IBOutlet weak var maritalSegmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        
        var option:String = "Not Married"
        if self.maritalSegmentedControl.selectedSegmentIndex == 1 {
            option = "Married"
        } else if self.maritalSegmentedControl.selectedSegmentIndex == 2 {
            option = "Prefer not to say"
        }
        NotificationCenter.default.post(name: Notification.Name("NotifyMaritalStatus"), object: option)
        dismiss(animated: true)
    }
}
