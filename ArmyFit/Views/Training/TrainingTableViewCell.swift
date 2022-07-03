//
//  TrainingTableViewCell.swift
//  ArmyFit
//
//  Created by Gabriel Policastro on 08/06/22.
//

import UIKit

class TrainingTableViewCell: UITableViewCell {

    //MARK: - Private properties
    @IBOutlet private weak var hourLabel: UILabel!
    @IBOutlet private weak var minuteLabel: UILabel!
    @IBOutlet private weak var coachNameLabel: UILabel!
    
    //MARK: - Public method
    func configure(viewModel: TrainingDetailViewModel) {
        hourLabel.text = viewModel.getHourTraining
        minuteLabel.text = viewModel.getMinuteTraining
        coachNameLabel.text = viewModel.getCoachName
    }
}
