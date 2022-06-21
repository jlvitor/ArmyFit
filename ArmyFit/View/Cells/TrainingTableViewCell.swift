//
//  TrainingTableViewCell.swift
//  ArmyFit
//
//  Created by Gabriel Policastro on 08/06/22.
//

import UIKit

struct TrainingCellViewModel {
    let text: String
}

class TrainingTableViewCell: UITableViewCell {

    @IBOutlet weak var coachNameLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    
    func configure(viewModel: TrainingCellViewModel) {
        coachNameLabel.text = viewModel.text
    }

}
