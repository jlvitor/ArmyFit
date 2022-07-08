//
//  TrainingViewController.swift
//  ArmyFit
//
//  Created by Gabriel Policastro on 21/06/22.
//

import UIKit

class TrainingViewController: UIViewController {
    
    //MARK: - Private properties
    @IBOutlet private weak var trainingTableView: UITableView!
    
    private let viewModel: TrainingsViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewModel()
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.trainingUserSections = []
        viewModel.fetchTrainingUser(Date.getCurrentDateToDateString())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? TrainingDetailViewController {
            if let index = sender as? (Int, Int) {
                detailVC.viewModel = viewModel.getTrainingDetail(index.0, index.1)
            }
        }
    }
    
    private func configTableView() {
        trainingTableView.delegate = self
        trainingTableView.dataSource = self
        trainingTableView.overrideUserInterfaceStyle = .dark
    }
    
    private func configViewModel() {
        viewModel.delegate = self
    }
}

//MARK: - UITableViewDelegate
extension TrainingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "trainingDetail", sender: (indexPath.section, indexPath.row))
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

//MARK: - UITableViewDataSource
extension TrainingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.trainingUserSections[section].trainings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trainingCell", for: indexPath) as? TrainingTableViewCell else {
            return UITableViewCell()
        }
        
        let cellViewModel = viewModel.getTrainingCellViewModel(indexPath.section, indexPath.row)
        cell.configure(viewModel: cellViewModel)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.trainingUserSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.trainingUserSections[section].name
    }
}

//MARK: - TrainingViewModelDelegate
extension TrainingViewController: TrainingViewModelDelegate {    
    func reloadData() {
        trainingTableView.reloadData()
    }
}
