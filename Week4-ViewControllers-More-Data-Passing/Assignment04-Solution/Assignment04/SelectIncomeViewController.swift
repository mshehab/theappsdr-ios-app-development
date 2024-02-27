//
//  SelectIncomeViewController.swift
//  Assignment04
//
//  Created by Mohamed Shehab on 2/5/24.
//

import UIKit

class SelectIncomeViewController: UIViewController {

    var incomeDelegate:DemographicProtocol?
    
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var incomeSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //<$25K, 0 - 1
    //$25K to <$50K, 1 - 2
    //$50K to <$100K,2 - 3
    //$100K to<$200K, 3- 4
    //and >$200K 4- 5
    
    var option = "$50K to <$100K"
    
    @IBAction func onSliderChanged(_ sender: UISlider) {
        
        if sender.value >= 0 && sender.value < 1 {
            option = "<$25K"
        } else if sender.value >= 1 && sender.value < 2 {
            option = "$25K to <$50K"
        } else if sender.value >= 2 && sender.value < 3 {
            option = "$50K to <$100K"
        } else if sender.value >= 3 && sender.value < 4 {
            option = "$100K to<$200K"
        } else {
            option = ">$200K"
        }
        incomeLabel.text = option
    }
  
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        self.incomeDelegate?.sendSelectedIncome(selection: self.option)
        dismiss(animated: true)
    }
    
}
