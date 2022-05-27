//
//  ScheduleTableViewCell.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 27/05/22.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var houerLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var exerciseTitleLabel: UILabel!
    @IBOutlet weak var coachLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
