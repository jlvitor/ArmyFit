//
//  ScheduleDetailViewController.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 30/05/22.
//

import UIKit

class ScheduleDetailViewController: UIViewController {
    
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var dayNumberLabel: UILabel!
    @IBOutlet weak var monitorLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var spotsLabel: UILabel!
    @IBOutlet weak var availableSpotsLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var detailTableView: UITableView!
    
    var viewModel: ScheduleDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewModel()
        configTableView()
    }

    //MARK: - Alerta do botao particiacao do treino
    @IBAction private func trainingParticipationButton(_ sender: UIButton) {
        viewModel?.registerButtonPressed()
    }
    
    //MARK: - Private method
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
        
        dayNameLabel.text = viewModel.getDayName()
        dayNumberLabel.text = viewModel.getDayNumber()
        monitorLabel.text = viewModel.getCoachName()
        hourLabel.text = viewModel.getHourTraining()
        minuteLabel.text = viewModel.getMinuteTraining()
        spotsLabel.text = viewModel.getSpots()
        availableSpotsLabel.text = viewModel.getAvailableSpots()
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
        
        let confirm = UIAlertAction(title: "Ok", style: .default) { action in
            self.viewModel?.addUserOnTraining()
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { action in
            print("Cancelado")
        }
        
        confirmAlert.addAction(confirm)
        confirmAlert.addAction(cancel)
        self.present(confirmAlert, animated: true)
    }
    
    func showAlertRemoveUserOnTraining() {
        let confirmAlert = UIAlertController(
            title: "Confirmação",
            message: "Deseja confirmar sua saida do treino?",
            preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "Ok", style: .default) { action in
            self.viewModel?.removeUserOnTraining()
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { action in
            print("Cancelado")
        }
        
        confirmAlert.addAction(confirm)
        confirmAlert.addAction(cancel)
        self.present(confirmAlert, animated: true)
    }
    
    func success() {
        viewModel?.fetchTrainingsHours(completion: {
            self.configScreen()
        })
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
        guard let rows = viewModel?.getNumberOfUsers() else { return 0}
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersCell", for: indexPath) as? ScheduleDetailTableViewCell
        if let cellViewModel = viewModel?.getTrainingDetailCellViewModel() {
            cell?.configure(indexPath.row, cellViewModel)
        }
                
        return cell ?? UITableViewCell()
    }
}
