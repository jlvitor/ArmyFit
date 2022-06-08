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
    @IBOutlet weak var spotsLabel: UILabel!
    @IBOutlet weak var availableSpostLabel: UILabel!
    
    func configure(_ viewModel: TrainingHoursViewModel) {
        houerLabel.text = viewModel.getHourTraining()
        minuteLabel.text = viewModel.getMinuteTraining()
        exerciseTitleLabel.text = viewModel.getTrainingName()
        coachLabel.text = viewModel.getCoachName()
        spotsLabel.text = viewModel.getSpots()
        availableSpostLabel.text = viewModel.getAvailableSpots()
    }

}
