//
//  SortSelectionViewController.swift
//  Assignment05
//
//  Created by Mohamed Shehab on 2/11/24.
//

import UIKit

class SortSelectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func nameAscClicked(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("SendSortNotification"), object: SortChoice(attribute: "name", direction: "asc"))
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nameDescClicked(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("SendSortNotification"), object: SortChoice(attribute: "name", direction: "desc"))
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ageAscClicked(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("SendSortNotification"), object: SortChoice(attribute: "age", direction: "asc"))
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ageDescClicked(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("SendSortNotification"), object: SortChoice(attribute: "age", direction: "desc"))
        self.navigationController?.popViewController(animated: true)
    }
}
