//
//  TrainingViewController.swift
//  ArmyFit
//
//  Created by Gabriel Policastro on 08/06/22.
//

import UIKit

class TrainingDetailViewController: UIViewController {
    
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var trainingLabel: UILabel!
    
    var viewModel: TrainingViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreen()
    }
    
    private func setScreen() {
        guard let viewModel = viewModel else { return }

        exerciseLabel.text = viewModel.getExerciseName
        warningLabel.text = viewModel.getWarning
        trainingLabel.text = viewModel.getDetail
    }
}

