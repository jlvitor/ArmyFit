//
//  ScheduleDetailViewController.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 30/05/22.
//

import UIKit

class ScheduleDetailViewController: UIViewController {
    
    @IBOutlet weak var monitorLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var spotsLabel: UILabel!
    @IBOutlet weak var availableSpotsLabel: UILabel!
    
    @IBOutlet weak var detailTableView: UITableView!
    
    var viewModel: ScheduleDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configScreen()
    }

    //MARK: - Alerta do botao particiacao do treino
    @IBAction func trainingParticipationButton(_ sender: UIButton) {
        let confirmAlert = UIAlertController(title: "Confirmação", message: "Deseja confirmar sua participação?", preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "Ok", style: .default) { action in
            print("OK")
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { action in
            print("Cancelado")
        }
        
        confirmAlert.addAction(confirm)
        confirmAlert.addAction(cancel)
        self.present(confirmAlert, animated: true)
    }
    
    //MARK: - Private method
    private func configTableView() {
        detailTableView.dataSource = self
        detailTableView.delegate = self
    }
    
    private func configScreen() {
        guard let viewModel = viewModel else { return }
        
        monitorLabel.text = viewModel.getCoachName()
        hourLabel.text = viewModel.getHourTraining()
        minuteLabel.text = viewModel.getMinuteTraining()
        spotsLabel.text = viewModel.getSpots()
        availableSpotsLabel.text = viewModel.getAvailableSpots()
        
    }
}

//MARK: - UITableViewDelegate
extension ScheduleDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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
//                let cellViewModel = viewModel.getUserCellViewModel(indexPath.row)
//                cell?.configure(cellViewModel)
        return cell ?? UITableViewCell()
    }
}

