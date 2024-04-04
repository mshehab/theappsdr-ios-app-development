//
//  GradesTableViewCell.swift
//  GradesApp
//
//  Created by Mohamed Shehab on 3/25/24.
//

import UIKit

protocol GradesDelegate {
    func deleteClicked(_ grade: Grade)
}

class GradesTableViewCell: UITableViewCell {
    @IBOutlet weak var letterGradeLabel: UILabel!
    @IBOutlet weak var courseNumberLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var semesterLabel: UILabel!
    @IBOutlet weak var creditHoursLabel: UILabel!
    
    var grade: Grade?
    var gradeDelegate: GradesDelegate?
    
    func bind(grade: Grade, gradeDelegage: GradesDelegate){
        self.grade = grade
        self.gradeDelegate = gradeDelegage
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onTrashClicked(_ sender: Any) {
        self.gradeDelegate?.deleteClicked(self.grade!)
    }
}
