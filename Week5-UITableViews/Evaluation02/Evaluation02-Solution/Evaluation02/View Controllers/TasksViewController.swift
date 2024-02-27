//
//  TasksViewController.swift
//  Evaluation02
//
//  Created by Mohamed Shehab on 2/26/24.
//

import UIKit

class TasksViewController: UIViewController {
    var tasks = [Task]()
    @IBOutlet weak var sortLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var sortOrder = "DESC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onReceiveNewTask(notification:)), name: Notification.Name("SendNewTask"), object: nil)
        self.tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
        
        tasks.append(Task(name: "Task 1", category: "Work/Professional", priority: 5, strPriority: "Very High"))
        tasks.append(Task(name: "Task 2", category: "Home & Family", priority: 4, strPriority: "High"))
        tasks.append(Task(name: "Task 3", category: "Finance", priority: 3, strPriority: "Medium"))
        
        refreshSort()
    }
    
    @objc func onReceiveNewTask(notification: Notification) {
        let task = notification.object as! Task
        tasks.append(task)
        refreshSort()
    }
    
    @IBAction func onClearAllClicked(_ sender: Any) {
        tasks.removeAll()
        tableView.reloadData()
    }
    
    @IBAction func onAscSortClicked(_ sender: Any) {
        sortOrder = "ASC"
        refreshSort()
    }
    
    @IBAction func onDescSortClicked(_ sender: Any) {
        sortOrder = "DESC"
        refreshSort()
    }
    
    
    func refreshSort(){
        sortLabel.text = "Sort by Priority (\(sortOrder))"
        
        if sortOrder == "DESC" {
            tasks.sort { t1, t2 in
                return t1.priority > t2.priority
            }
            tableView.reloadData()
        } else {
            tasks.sort { t1, t2 in
                return t1.priority < t2.priority
            }
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GotoTaskDetailsSegue" {
            let vc = segue.destination as! TaskDetailsViewController
            let task = tasks[tableView.indexPathForSelectedRow!.row]
            vc.task = task
            self.tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
}

extension TasksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        
        let task = tasks[indexPath.row]
        
        cell.nameLabel.text = task.name
        cell.categoryLabel.text = task.category
        cell.priorityLabel.text = task.strPriority
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "GotoTaskDetailsSegue", sender: self)
    }
    
    
}
