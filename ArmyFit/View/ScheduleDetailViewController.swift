//
//  ScheduleDetailViewController.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 30/05/22.
//

import UIKit

class ScheduleDetailViewController: UIViewController {
    
    @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var monitorLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    
    
    private let viewModel: TrainingDetailViewModel = TrainingDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configViewModel()
        
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
    
    private func configTableView() {
        detailTableView.dataSource = self
        detailTableView.delegate = self
    }
    
    private func configViewModel() {
        viewModel.delegate = self
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersCell", for: indexPath) as? ScheduleDetailTableViewCell
        cell?.posterUser.image = UIImage(systemName: "person.fill")
        cell?.userNameLabel.text = "Mitchell"
        return cell ?? UITableViewCell()
    }
}

extension ScheduleDetailViewController: TrainingDetailViewModelDelegate {
    func success(_ viewModel: TrainingHoursViewModel) {
        monitorLabel.text = viewModel.getCoachName()
        hourLabel.text = viewModel.getHourTraining()
        minuteLabel.text = viewModel.getMinuteTraining()
        
    }
    
    func errorRequest() {
        print("Erro ao carregar detalhes")
    }
    
    
}

