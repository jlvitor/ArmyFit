//
//  TrainingViewController.swift
//  ArmyFit
//
//  Created by Gabriel Policastro on 08/06/22.
//

import UIKit

class TrainingDetailViewController: UIViewController {
    
    //MARK: - Private properties
    @IBOutlet private weak var exerciseLabel: UILabel!
    @IBOutlet private weak var warningLabel: UILabel!
    @IBOutlet private weak var trainingLabel: UILabel!
    
    //MARK: - Public propertie
    var viewModel: TrainingViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScreen()
    }
    
    //MARK: - Private method
    private func setScreen() {
        guard let viewModel = viewModel else { return }

        exerciseLabel.text = viewModel.getExerciseName
        warningLabel.text = viewModel.getWarning
        trainingLabel.text = viewModel.getDetail
    }
}

