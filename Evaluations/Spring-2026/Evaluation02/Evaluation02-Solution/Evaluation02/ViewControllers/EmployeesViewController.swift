//
//  ViewController.swift
//  Evaluation02
//
//  Created by Mohamed Shehab on 3/4/26.
//

import UIKit

class EmployeesViewController: UIViewController {
    var filteredEmployees = [Employee]()
    var allEmployees = [Employee]()
    var selectedDepartments = Set<String>()
    var selectedEmployee: Employee?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeeTableViewCell")
        allEmployees.append(contentsOf: DataService.getInstance().employees)
        filteredEmployees.append(contentsOf: allEmployees)
    }
    @IBAction func selectClicked(_ sender: Any) {
    }
    
    @IBAction func resetClicked(_ sender: Any) {
        self.filteredEmployees.removeAll()
        self.filteredEmployees.append(contentsOf: allEmployees)
        self.selectedDepartments.removeAll()
        self.tableView.reloadData()
        self.filterlabel.text = "All Records"
    }
    @IBOutlet weak var filterlabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectFilterDeptSegue" {
            let nav = segue.destination as! UINavigationController
            let vc = nav.viewControllers.first as! SelectFilterDepartmentViewController
            vc.filterDelegate = self
        } else if segue.identifier == "GotoPurchasesSegue" {
            let vc = segue.destination as! PurchasesViewController
            vc.employee = self.selectedEmployee
            self.selectedEmployee = nil
        }
    }
    
}

extension EmployeesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEmployees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell", for: indexPath) as! EmployeeTableViewCell
        let employee = filteredEmployees[indexPath.row]
        
        cell.deptLabel.text = employee.department
        cell.nameLabel.text = employee.name
        cell.purchasesLabel.text = "\(employee.purchases.count) Purchases"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedEmployee = filteredEmployees[indexPath.row]
        performSegue(withIdentifier: "GotoPurchasesSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension EmployeesViewController: FilterDeptDelegate{
    func didUpdateSelectedDepartments(_ selectedDepartments: Set<String>) {
        self.selectedDepartments.removeAll()
        self.selectedDepartments.formUnion(selectedDepartments)
        filteredEmployees.removeAll()
        for emp in allEmployees {
            if self.selectedDepartments.contains(emp.department) {
                filteredEmployees.append(emp)
            }
        }
        self.tableView.reloadData()
        self.filterlabel.text = self.selectedDepartments.joined(separator: ", ")
    }
}

