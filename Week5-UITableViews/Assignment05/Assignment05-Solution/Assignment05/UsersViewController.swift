//
//  UsersViewController.swift
//  Assignment05
//
//  Created by Mohamed Shehab on 2/11/24.
//

import UIKit

class UsersViewController: UIViewController {
    var users = [User]()
    
    @IBOutlet weak var sortLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onUserReceive(notification:)), name: Notification.Name("SendUserNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onSortReceive(notification:)), name: Notification.Name("SendSortNotification"), object: nil)

        users.append(User(name: "Bob Smith", email: "b@b.com", gender: "Male", age: 33, state: "North Carolina", group: "Friend"))
        users.append(User(name: "Alice Smith", email: "a@a.com", gender: "Female", age: 20, state: "South Carolina", group: "Family"))
        users.append(User(name: "Tom Smith", email: "t@t.com", gender: "Male", age: 50, state: "New York", group: "Friend"))
        
        users.sort { u1, u2 in
            return u2.name > u1.name
        }
        
        sortLabel.text = "Sort by Name (ASC)"
    }

    @objc func onSortReceive(notification: Notification){
        let sortChoice = notification.object as! SortChoice
        
        sortLabel.text = "Sort by \(sortChoice.attribute) (\(sortChoice.direction.uppercased()))"
        
        if sortChoice.attribute == "name" {
            
            if sortChoice.direction == "desc"{
                users.sort { u1, u2 in
                    return u1.name > u2.name
                }
            } else {
                users.sort { u1, u2 in
                    return u2.name > u1.name
                }
            }
            
            
        } else if sortChoice.attribute == "age"{
            if sortChoice.direction == "desc"{
                users.sort { u1, u2 in
                    return u1.age > u2.age
                }
            } else {
                users.sort { u1, u2 in
                    return u2.age > u1.age
                }
            }
        }
        
        tableView.reloadData()
    }
    
    
    @objc func onUserReceive(notification: Notification){
        let user = notification.object as! User
        users.append(user)    
        tableView.reloadData()
        
    }
    
    @IBAction func clearAllClicked(_ sender: Any) {
        users.removeAll()
        tableView.reloadData()
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let user = users[indexPath.row]
        
        let nameLabel = cell.viewWithTag(100) as! UILabel
        nameLabel.text = user.name
        
        let emailLabel = cell.viewWithTag(200) as! UILabel
        emailLabel.text = user.email
        
        let ageLabel = cell.viewWithTag(300) as! UILabel
        ageLabel.text = "\(user.age) years old"
        
        let genderLabel = cell.viewWithTag(400) as! UILabel
        genderLabel.text = user.gender
        
        let groupLabel = cell.viewWithTag(500) as! UILabel
        groupLabel.text = user.group
        
        
        return cell
    }
    
    
    
    
}
