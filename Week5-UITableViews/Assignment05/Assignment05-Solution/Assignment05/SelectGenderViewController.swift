//
//  SelectGenderViewController.swift
//  Assignment05
//
//  Created by Mohamed Shehab on 2/11/24.
//

import UIKit

class SelectGenderViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var genders = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genders.append(contentsOf: Data.genders)
    }
}

extension SelectGenderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenderCell", for: indexPath)

        cell.textLabel?.text = genders[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gender = genders[indexPath.row]
        NotificationCenter.default.post(name: Notification.Name("SendGenderNotification"), object: gender)
        self.navigationController?.popViewController(animated: true)
    }
}
