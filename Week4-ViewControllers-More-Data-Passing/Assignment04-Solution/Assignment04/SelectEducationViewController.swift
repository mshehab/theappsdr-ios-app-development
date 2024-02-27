//
//  SelectEducationViewController.swift
//  Assignment04
//
//  Created by Mohamed Shehab on 2/5/24.
//

import UIKit

class SelectEducationViewController: UIViewController {

    var option:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToDemographicFromEdu" {
            let vc = segue.destination as! DemographicViewController
            vc.response?.education = self.option
        }
    }
    
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func optionClicked(_ sender: UIButton) {
        self.option = sender.titleLabel!.text
        
        performSegue(withIdentifier: "unwindToDemographicFromEdu", sender: self)
    }
    

}
