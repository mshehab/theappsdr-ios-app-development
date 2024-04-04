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
        let postText = postTextField.text!
        if postText.isEmpty {
            showAlertWith(title: "Post Error", message: "Post text is required !!", okAlertAction: nil)
        } else {
            
            
            
        }
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
