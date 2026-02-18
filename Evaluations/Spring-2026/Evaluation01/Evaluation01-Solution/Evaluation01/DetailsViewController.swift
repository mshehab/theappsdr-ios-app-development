//
//  DetailsViewController.swift
//  Evaluation01
//
//  Created by Mohamed Shehab on 2/18/26.
//

import UIKit

class DetailsViewController: UIViewController {
    var calorie: Calorie?
    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    
    @IBOutlet weak var bmrLabel: UILabel!
    @IBOutlet weak var tdeeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let calorie = calorie {
            self.genderLabel.text = calorie.gender
            self.activityLabel.text = calorie.activityLevel
            self.weightLabel.text = "\(calorie.weight) lbs"
            let heightString = "\(calorie.heightFt) ft \(calorie.heightIn) in"
            self.heightLabel.text = heightString
            self.ageLabel.text = "\(calorie.age)"
            self.bmrLabel.text = "\(calorie.bmr) kcal/day"
            self.tdeeLabel.text = "\(calorie.tdee) kcal/day"
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
