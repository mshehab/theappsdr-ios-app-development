//
//  AddUserViewController.swift
//  Assignment05
//
//  Created by Mohamed Shehab on 2/11/24.
//

import UIKit

class AddUserViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onGenderSelectionReceive(notification:)), name: Notification.Name("SendGenderNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onAgeSelectionReceive(notification:)), name: Notification.Name("SendAgeNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onStateSelectionReceive(notification:)), name: Notification.Name("SendStateNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onGroupSelectionReceive(notification:)), name: Notification.Name("SendGroupNotification"), object: nil)

        
    }
    
    @IBOutlet weak var genderLabel: UILabel!
    var gender:String?

    @objc func onGenderSelectionReceive(notification: Notification){
        gender = notification.object as? String
        self.genderLabel.text = gender
    }
    
    @IBOutlet weak var stateLabel: UILabel!
    var state:String?

    @objc func onStateSelectionReceive(notification: Notification){
        state = notification.object as? String
        self.stateLabel.text = state
    }
    
    @IBOutlet weak var groupLabel: UILabel!
    var group:String?

    @objc func onGroupSelectionReceive(notification: Notification){
        group = notification.object as? String
        self.groupLabel.text = group
    }
    
    
    @IBOutlet weak var ageLabel: UILabel!
    var age:Int?

    @objc func onAgeSelectionReceive(notification: Notification){
        age = notification.object as? Int
        self.ageLabel.text = String(age!)
    }
    
    
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBAction func onSubmitClicked(_ sender: Any) {
        let name = nameLabel.text
        let email = emailLabel.text
        
        
        
        let user = User(name: name!, email: email!, gender: self.gender!, age: self.age!, state: self.state!, group: self.group!)
        
        NotificationCenter.default.post(name: Notification.Name("SendUserNotification"), object: user)
        self.navigationController?.popViewController(animated: true)
    }
    
}
