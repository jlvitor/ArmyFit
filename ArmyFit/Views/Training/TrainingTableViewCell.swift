//
//  TrainingTableViewCell.swift
//  ArmyFit
//
//  Created by Gabriel Policastro on 08/06/22.
//

import UIKit

class TrainingTableViewCell: UITableViewCell {

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var coachNameLabel: UILabel!
    
    func configure(viewModel: TrainingDetailViewModel) {
        hourLabel.text = viewModel.getHourTraining()
        minuteLabel.text = viewModel.getMinuteTraining()
        coachNameLabel.text = viewModel.getCoachName()
    }

}
