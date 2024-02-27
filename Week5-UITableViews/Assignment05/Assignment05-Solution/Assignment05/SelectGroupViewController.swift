//
//  SelectGroupViewController.swift
//  Assignment05
//
//  Created by Mohamed Shehab on 2/11/24.
//

import UIKit

class SelectGroupViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var groups = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groups.append(contentsOf: Data.groups)
    }
}

 extension SelectGroupViewController: UITableViewDataSource, UITableViewDelegate {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return groups.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)

         cell.textLabel?.text = groups[indexPath.row]
         return cell
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let group = groups[indexPath.row]
         NotificationCenter.default.post(name: Notification.Name("SendGroupNotification"), object: group)
         self.navigationController?.popViewController(animated: true)
     }
 }

