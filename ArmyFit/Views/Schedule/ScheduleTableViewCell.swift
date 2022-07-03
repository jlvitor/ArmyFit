//
//  ScheduleTableViewCell.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 27/05/22.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    //MARK: - Private properties
    @IBOutlet private weak var houerLabel: UILabel!
    @IBOutlet private weak var minuteLabel: UILabel!
    @IBOutlet private weak var exerciseTitleLabel: UILabel!
    @IBOutlet private weak var coachLabel: UILabel!
    @IBOutlet private weak var spotsLabel: UILabel!
    @IBOutlet private weak var availableSpostLabel: UILabel!
    
    //MARK: - Public method
    func configure(_ viewModel: ScheduleViewModel) {
        houerLabel.text = viewModel.getHourTraining
        minuteLabel.text = viewModel.getMinuteTraining
        exerciseTitleLabel.text = viewModel.getTrainingName
        coachLabel.text = viewModel.getCoachName
        spotsLabel.text = viewModel.getSpots
        availableSpostLabel.text = viewModel.getAvailableSpots
    }

}
