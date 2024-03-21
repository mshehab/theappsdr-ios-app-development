//
//  GiftListsViewController.swift
//  GiftsApp
//
//  Created by Mohamed Shehab on 3/18/24.
//

import UIKit

class GiftListsViewController: UIViewController {

    let token : String = SceneDelegate.getToken()!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutClicked(_ sender: Any) {
        SceneDelegate.logout()
        SceneDelegate.showLogin()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
