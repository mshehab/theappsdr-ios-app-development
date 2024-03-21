//
//  GiftListsViewController.swift
//  GiftsApp
//
//  Created by Mohamed Shehab on 3/18/24.
//

import UIKit
import Alamofire
import SwiftyJSON
import PKHUD

class GiftListsViewController: UIViewController {

    let token : String = SceneDelegate.getToken()!
    
    @IBOutlet weak var tableView: UITableView!
    var giftLists = [GiftList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "GiftTableViewCell", bundle: nil), forCellReuseIdentifier: "GiftTableViewCell")
        
        //NotificationCenter.default.post(name: Notification.Name("ReloadGiftListNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataNotification(notification:)), name: Notification.Name("ReloadGiftListNotification"), object: nil)
        
        getGiftLists()
    }
    

    @objc func reloadDataNotification(notification: Notification){
        getGiftLists()
    }
    
    
    @IBAction func logoutClicked(_ sender: Any) {
        SceneDelegate.logout()
        SceneDelegate.showLogin()
    }
    
    
    func getGiftLists(){
        
        
        
        let headers: HTTPHeaders = [
            "Authorization": "BEARER \(token)"
        ]
        
        
        HUD.show(.labeledProgress(title: "Getting Gift Lists", subtitle: "Please wait!"))
        
        AF.request("https://www.theappsdr.com/api/giftlists/lists", method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                HUD.hide()
                
                switch response.result {
                case .success:
                    print("Validation Successful")
                    if let data = response.data{
                        if let json = try? JSON(data: data){
                            self.giftLists.removeAll()
                            let listsArray = json["lists"].arrayValue
                            for item in listsArray {
                                let giftlist = GiftList(item)
                                self.giftLists.append(giftlist)
                            }
                            self.tableView.reloadData()
                        }
                    }
                case let .failure(error):
                    print(error)
                }
            }
        
    }

    func callDeleteAPIGiftList(_ gid: String){
        
        let parameters = [
            "gid": gid
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "BEARER \(token)"
        ]
        
        
        HUD.show(.labeledProgress(title: "Deleting Gift Lists", subtitle: "Please wait!"))
        
        AF.request("https://www.theappsdr.com/api/giftlists/delete", method: .post, parameters: parameters,  headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                HUD.hide()
                switch response.result {
                case .success:
                    self.getGiftLists()
                case let .failure(error):
                    print(error)
                }
            }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GotoGiftListDetailsSegue" {
            let indexPath = tableView.indexPathForSelectedRow!
            let giftList = giftLists[indexPath.row]
            let vc = segue.destination as! GiftListViewController
            vc.giftList = giftList
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension GiftListsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return giftLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GiftTableViewCell", for: indexPath) as! GiftTableViewCell
        
        let giftlist = giftLists[indexPath.row]
        cell.cellDelegate = self
        cell.gid = giftlist.gid
        cell.nameLabel.text = giftlist.name
        cell.totalCostLabel.text = "$\(giftlist.totalCost)"
        cell.itemsCountLabel.text = "\(giftlist.totalCount) items"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "GotoGiftListDetailsSegue", sender: self)
    }
}

extension GiftListsViewController : GiftCellDelegate {
    func deleteGiftList(_ gid: String) {
        self.callDeleteAPIGiftList(gid)
    }
}
