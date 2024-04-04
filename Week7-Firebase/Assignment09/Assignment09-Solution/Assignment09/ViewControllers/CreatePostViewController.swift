//
//  CreatePostViewController.swift
//  Assignment08
//
//  Created by Mohamed Shehab on 3/13/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

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

            let db = Firestore.firestore()
            
            let docRef = db.collection("posts").document()
            
            let data : [String: Any] = [
                "postText": postText,
                "createdByName" : Auth.auth().currentUser!.displayName!,
                "createdByUid" : Auth.auth().currentUser!.uid,
                "createdAt" : FieldValue.serverTimestamp(),
                "docId" : docRef.documentID
            ]
            
            docRef.setData(data) { error in
                if let error = error {
                    self.showAlertWith(title: "Post Error", message: error.localizedDescription, okAlertAction: nil)
                } else {
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
