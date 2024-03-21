//
//  CreatePostViewController.swift
//  Assignment08
//
//  Created by Mohamed Shehab on 3/13/24.
//

import UIKit

class CreatePostViewController: UIViewController {

    @IBOutlet weak var postTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func submitClicked(_ sender: Any) {
        
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
