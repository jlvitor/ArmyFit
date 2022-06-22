//
//  TrainingViewController.swift
//  ArmyFit
//
//  Created by Gabriel Policastro on 21/06/22.
//

import UIKit

class TrainingViewController: UIViewController {
    
    @IBOutlet weak var trainingTableView: UITableView!
    
    private let viewModel: TrainingViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewModel()
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchTrainingUser(Date.getCurrentDateToDateString())
    }
    
    private func configTableView() {
        trainingTableView.delegate = self
        trainingTableView.dataSource = self
    }
    
    private func configViewModel() {
        viewModel.delegate = self
        viewModel.fetchTrainingUser(Date.getCurrentDateToDateString())
    }
}

//MARK: - UITableViewDelegate
extension TrainingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension TrainingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.trainingCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trainingCell", for: indexPath) as? TrainingTableViewCell
        let cellViewModel = viewModel.getTrainingCellViewModel(indexPath.row)
        cell?.configure(viewModel: cellViewModel)
        return cell ?? UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = "CROSSFIT"
        return title
    }
}

extension TrainingViewController: TrainingViewModelDelegate {
    func reloadData() {
        trainingTableView.reloadData()
    }
}
