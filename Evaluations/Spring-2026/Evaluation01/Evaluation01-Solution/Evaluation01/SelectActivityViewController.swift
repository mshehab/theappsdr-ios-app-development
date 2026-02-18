//
//  SelectActivityViewController.swift
//  Evaluation01
//
//  Created by Mohamed Shehab on 2/18/26.
//

import UIKit

class SelectActivityViewController: UIViewController {
    var selectionDelegate: SelectDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func submitClicked(_ sender: UIButton) {
        if let activity = sender.titleLabel?.text {
            if let delegate = selectionDelegate {
                delegate.didSelect(activity:activity)
            }
        }
        dismiss(animated: true)
    }
}
