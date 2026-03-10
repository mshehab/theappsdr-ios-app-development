//
//  ViewController.swift
//  Evaluation02
//
//  Created by Mohamed Shehab on 3/4/26.
//

import UIKit

class EmployeesViewController: UIViewController {
    var employees = [Employee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employees.append(contentsOf: DataService.getInstance().employees)
    }
}

