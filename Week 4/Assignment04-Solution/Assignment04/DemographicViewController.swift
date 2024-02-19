//
//  DemographicViewController.swift
//  Assignment04
//
//  Created by Mohamed Shehab on 2/5/24.
//

import UIKit


protocol DemographicProtocol {
    func sendSelectedIncome(selection: String)
}

class DemographicViewController: UIViewController {
    var response:Response?
    
    
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var maritalLabel: UILabel!
    @IBOutlet weak var eduLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onReceiveMarialStatus(notification: )), name: Notification.Name("NotifyMaritalStatus"), object: nil)
    }
    
    @objc func onReceiveMarialStatus(notification: Notification){
        if notification.object != nil {
            maritalLabel.text = (notification.object as! String)
        } else {
            maritalLabel.text = "N/A"
        }
    }
    
    
    @IBAction func unwindFromEdu(unwindSegue: UIStoryboardSegue){
        print(response?.education)
    
        if response!.education == nil {
            eduLabel.text = "N/A"
        } else {
            eduLabel.text = response?.education
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoSelectIncome" {
            let vc = segue.destination as! SelectIncomeViewController
            vc.incomeDelegate = self
        }
    }

}

extension DemographicViewController: DemographicProtocol {
    func sendSelectedIncome(selection: String) {
        response?.income = selection
        incomeLabel.text = selection
    }
}
