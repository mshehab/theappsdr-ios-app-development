//
//  SelectAgeViewController.swift
//  Assignment05
//
//  Created by Mohamed Shehab on 2/11/24.
//

import UIKit

class SelectAgeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var ages = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 18...100 {
            ages.append(i)
        }
    }
}

extension SelectAgeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgeCell", for: indexPath)

        cell.textLabel?.text = String(ages[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let age = ages[indexPath.row]
        NotificationCenter.default.post(name: Notification.Name("SendAgeNotification"), object: age)
        self.navigationController?.popViewController(animated: true)
    }
}
