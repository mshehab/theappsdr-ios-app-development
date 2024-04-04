//
//  CourseReviewTableViewCell.swift
//  GradesApp
//
//  Created by Mohamed Shehab on 3/25/24.
//

import UIKit

protocol CourseReviewDelegate {
    func heartClicked(_ course: Course)
}

class CourseReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var courseNumberLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var creditHoursLabel: UILabel!
    @IBOutlet weak var numReviewsLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    var course: Course?
    var courseReviewDelegate: CourseReviewDelegate?
    
    func bind(course: Course, courseReviewDelegate: CourseReviewDelegate){
        self.course = course
        self.courseReviewDelegate = courseReviewDelegate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func onHeartClicked(_ sender: Any) {
        self.courseReviewDelegate!.heartClicked(self.course!)
    }
    
}
