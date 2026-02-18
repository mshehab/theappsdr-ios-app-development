//
//  ViewController.swift
//  Evaluation01
//
//  Created by Mohamed Shehab on 2/18/26.
//

import UIKit

protocol SelectDelegate {
    func didSelect(gender: String)
    func didSelect(activity: String)
    func didSelect(weight: Double)
    func didSelect(heightFt: Double, heightIn: Double)
    func didSelect(age: Int)
}

class ViewController: UIViewController {
    var gender: String?
    var activity: String?
    var weight: Double?
    var age: Int?
    var heightFt: Double?
    var heightIn: Double?
    var calorie: Calorie?
    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        if gender == nil || activity == nil || weight == nil || age == nil || heightFt == nil || heightIn == nil {
            showAlert(title: "Error", message: "Please fill all fields")
        } else {
            calorie = Calorie(age: age!, gender: gender!, weight: weight!, heightFt: heightFt!, heightIn: heightIn!, activityLevel: activity!)
            performSegue(withIdentifier: "DetailsSegue", sender: self)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GenderSegue"{
            let nav = segue.destination as! UINavigationController
            let selectVC = nav.viewControllers.first as! SelectGenderViewController
            selectVC.selectionDelegate = self            
        } else if segue.identifier == "AgeSegue"{
            let nav = segue.destination as! UINavigationController
            let selectVC = nav.viewControllers.first as! SelectAgeViewController
            selectVC.selectionDelegate = self
        } else if segue.identifier == "WeightSegue"{
            let nav = segue.destination as! UINavigationController
            let selectVC = nav.viewControllers.first as! SelectWeightViewController
            selectVC.selectionDelegate = self
        } else if segue.identifier == "HeightSegue"{
            let nav = segue.destination as! UINavigationController
            let selectVC = nav.viewControllers.first as! SelectHeightViewController
            selectVC.selectionDelegate = self
        } else if segue.identifier == "ActivitySegue"{
            let nav = segue.destination as! UINavigationController
            let selectVC = nav.viewControllers.first as! SelectActivityViewController
            selectVC.selectionDelegate = self
        } else if segue.identifier == "DetailsSegue" {
            let nav = segue.destination as! UINavigationController
            let detailsVC = nav.viewControllers.first as! DetailsViewController
            detailsVC.calorie = calorie
        }
    }
}


extension ViewController: SelectDelegate {
    func didSelect(gender: String) {
        self.gender = gender
        self.genderLabel.text = gender
    }
    
    func didSelect(activity: String) {
        self.activity = activity
        self.activityLabel.text = activity
    }
    
    func didSelect(weight: Double) {
        self.weight = weight
        self.weightLabel.text = "\(weight) lbs"
    }
    
    func didSelect(heightFt: Double, heightIn: Double) {
        self.heightFt = heightFt
        self.heightIn = heightIn
        self.heightLabel.text = "\(heightFt) ft \(heightIn) in"
    }
    
    func didSelect(age: Int) {
        self.age = age
        self.ageLabel.text = "\(age)"
    }
    
}

