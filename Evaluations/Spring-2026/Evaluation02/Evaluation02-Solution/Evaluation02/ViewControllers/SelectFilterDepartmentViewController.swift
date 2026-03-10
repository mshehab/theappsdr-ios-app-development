//
//  SelectFilterDepartmentViewController.swift
//  Evaluation02
//
//  Created by Mohamed Shehab on 3/4/26.
//

import UIKit

protocol FilterDeptDelegate {
    func didUpdateSelectedDepartments(_ selectedDepartments: Set<String>)
}

class SelectFilterDepartmentViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var uniqueDepartmentsSet = Set<String>()
    var uniqueDepartments = [String]()
    var selectedDepartments = Set<String>()
    var filterDelegate: FilterDeptDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uniqueDepartmentsSet.removeAll()
        uniqueDepartments.removeAll()
        for emp in DataService.getInstance().employees {
            uniqueDepartmentsSet.insert(emp.department)
        }
        uniqueDepartments.append(contentsOf: uniqueDepartmentsSet)
        tableView.register(UINib(nibName: "DepartmentTableViewCell", bundle: nil), forCellReuseIdentifier: "DepartmentTableViewCell")
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        if !selectedDepartments.isEmpty {
            if let delegate = filterDelegate {
                delegate.didUpdateSelectedDepartments(selectedDepartments)
                self.dismiss(animated: true)
            }
        }
    }
}

extension SelectFilterDepartmentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uniqueDepartments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepartmentTableViewCell", for: indexPath) as! DepartmentTableViewCell
        let dept = uniqueDepartments[indexPath.row]
        cell.mainLabel.text = dept
        
        if selectedDepartments.contains(dept) {
            cell.iconImageView.image = UIImage(named: "ic_check_fill")
        } else {
            cell.iconImageView.image = UIImage(named: "ic_check_not_fill")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dept = uniqueDepartments[indexPath.row]
        if selectedDepartments.contains(dept) {
            selectedDepartments.remove(dept)
        } else {
            selectedDepartments.insert(dept)
        }
        tableView.reloadData()
    }
}
