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

    @IBOutlet weak var trainingLabel: UILabel!
    
    func configure(viewModel: TrainingCellViewModel) {
        trainingLabel.text = viewModel.text
    }

}
