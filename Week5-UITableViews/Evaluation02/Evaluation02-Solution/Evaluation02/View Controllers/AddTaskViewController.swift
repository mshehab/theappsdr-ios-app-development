//
//  AddTaskViewController.swift
//  Evaluation02
//
//  Created by Mohamed Shehab on 2/26/24.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var prioritySelector: UISegmentedControl!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onReceiveCategory(notification:)), name: Notification.Name("SendCategory"), object: nil)
    }
    
    var category: String?
    @objc func onReceiveCategory(notification: Notification) {
        category = notification.object as? String
        categoryLabel.text = category
    }
    
    @IBAction func onSubmitClicked(_ sender: Any) {
        let name = nameTextField.text
        
        var priorityStr = "Very High"
        
        if name!.isEmpty {
            
        } else if category == nil {
            
            
        } else {
            var priority = prioritySelector.numberOfSegments - prioritySelector.selectedSegmentIndex
            
            if prioritySelector.selectedSegmentIndex == 0 {
                priorityStr = "Very High"
            } else if prioritySelector.selectedSegmentIndex == 1 {
                priorityStr = "High"
            } else if prioritySelector.selectedSegmentIndex == 2 {
                priorityStr = "Medium"
            } else if prioritySelector.selectedSegmentIndex == 3 {
                priorityStr = "Low"
            } else if prioritySelector.selectedSegmentIndex == 4 {
                priorityStr = "Very Low"
            }
            
            let task = Task(name: name!, category: category!, priority: priority, strPriority: priorityStr)
            NotificationCenter.default.post(name: Notification.Name("SendNewTask"), object: task)
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
}
