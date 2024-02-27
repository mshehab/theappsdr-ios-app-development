//
//  SelectCategoryViewController.swift
//  Evaluation02
//
//  Created by Mohamed Shehab on 2/26/24.
//

import UIKit

class SelectCategoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SelectCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel!.text = Data.categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: Notification.Name("SendCategory"), object: Data.categories[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}
