//
//  ScheduleDetailViewController.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 30/05/22.
//

import UIKit

class ScheduleDetailViewController: UIViewController {
    
    //MARK: - Private properties
    @IBOutlet private weak var dayNameLabel: UILabel!
    @IBOutlet private weak var dayNumberLabel: UILabel!
    @IBOutlet private weak var monitorLabel: UILabel!
    @IBOutlet private weak var hourLabel: UILabel!
    @IBOutlet private weak var minuteLabel: UILabel!
    @IBOutlet private weak var spotsLabel: UILabel!
    @IBOutlet private weak var availableSpotsLabel: UILabel!
    @IBOutlet private weak var registerButton: UIButton!
    
    @IBOutlet private weak var detailTableView: UITableView!
    
    //MARK: - Public propertie
    var viewModel: ScheduleDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewModel()
        configTableView()
    }

    //MARK: - Private methods
    @IBAction private func trainingParticipationButton(_ sender: UIButton) {
        viewModel?.registerButtonPressed()
    }
    
    private func configTableView() {
        detailTableView.dataSource = self
        detailTableView.delegate = self
        detailTableView.overrideUserInterfaceStyle = .dark
    }
    
    private func configViewModel() {
        viewModel?.delegate = self
        viewModel?.registerDelegate = self
        viewModel?.fetchTrainingsHours(completion: {
            self.configScreen()
        })
    }
    
    private func configScreen() {
        guard let viewModel = viewModel else { return }
        
        dayNameLabel.text = viewModel.getDayName
        dayNumberLabel.text = viewModel.getDayNumber
        monitorLabel.text = viewModel.getCoachName
        hourLabel.text = viewModel.getHourTraining
        minuteLabel.text = viewModel.getMinuteTraining
        spotsLabel.text = viewModel.getSpots
        availableSpotsLabel.text = viewModel.getAvailableSpots
        registerButton.setTitle(viewModel.getRegisterButtonTitle(), for: .normal)
    }
}

//MARK: - RegisterOnTrainingDelegate
extension ScheduleDetailViewController: RegisterOnTrainingDelegate {
    func showAlertAddUserOnTraining() {
        let confirmAlert = UIAlertController(
            title: "Confirmação",
            message: "Deseja confirmar sua participação?",
            preferredStyle: .alert)
        
        let confirm = UIAlertAction(
            title: "Ok",
            style: .default) { action in
            self.viewModel?.addUserOnTraining()
        }
        
        let cancel = UIAlertAction(
            title: "Cancelar",
            style: .cancel)
        
        confirmAlert.addAction(confirm)
        confirmAlert.addAction(cancel)
        self.present(confirmAlert, animated: true)
    }
    
    func showAlertRemoveUserOnTraining() {
        let confirmAlert = UIAlertController(
            title: "Confirmação",
            message: "Deseja confirmar sua saida do treino?",
            preferredStyle: .alert)
        
        let confirm = UIAlertAction(
            title: "Ok",
            style: .default) { action in
            self.viewModel?.removeUserOnTraining()
        }
        
        let cancel = UIAlertAction(
            title: "Cancelar",
            style: .cancel)
        
        confirmAlert.addAction(confirm)
        confirmAlert.addAction(cancel)
        self.present(confirmAlert, animated: true)
    }
    
    func success() {
        viewModel?.fetchTrainingsHours {
            self.configScreen()
        }
    }
}

//MARK: - ScheduleDetailViewModelDelegate
extension ScheduleDetailViewController: ScheduleDetailViewModelDelegate {
    func reloadData() {
        detailTableView.reloadData()
    }
}

//MARK: - UITableViewDelegate
extension ScheduleDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

//MARK: - UITableViewDataSource
extension ScheduleDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfUsers ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "usersCell", for: indexPath) as? ScheduleDetailTableViewCell else {
            return UITableViewCell()
        }
        
        if let cellViewModel = viewModel?.getTrainingDetailCellViewModel() {
            cell.configure(indexPath.row, cellViewModel)
        }
                
        return cell
    }
}
