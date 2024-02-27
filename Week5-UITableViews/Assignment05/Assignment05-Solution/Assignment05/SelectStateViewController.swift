//
//  SelectStateViewController.swift
//  Assignment05
//
//  Created by Mohamed Shehab on 2/11/24.
//

import UIKit

class SelectStateViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var states = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        states.append(contentsOf: Data.states)
    }
}

extension SelectStateViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StateCell", for: indexPath)

        cell.textLabel?.text = states[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state = states[indexPath.row]
        NotificationCenter.default.post(name: Notification.Name("SendStateNotification"), object: state)
        self.navigationController?.popViewController(animated: true)
    }
}
