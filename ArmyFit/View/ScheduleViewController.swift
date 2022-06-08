//
//  ScheduleViewController.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 27/05/22.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet weak var dateCollectionView: UICollectionView!
    @IBOutlet weak var scheduleTableView: UITableView!
    
    private let viewModel: TrainingsHoursViewModel = TrainingsHoursViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewModel()
        configCollectionView()
        configTableView()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let detailVC = segue.destination as? ScheduleDetailViewController {
//            let index = sender as? Int
//            detailVC.viewModel = viewModel.getTrainingDetail(index)
//        }
//    }
    
    //MARK: - Private methods
    private func configCollectionView() {
        dateCollectionView.dataSource = self
        dateCollectionView.delegate = self
    }
    
    private func configTableView() {
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        scheduleTableView.overrideUserInterfaceStyle = .dark
    }
    
    private func configViewModel() {
        viewModel.daysOnCurrentMonth()
        viewModel.fetchTrainingsHours()
    }
}

//MARK: - UICollectionViewDelegate
extension ScheduleViewController: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDataSource
extension ScheduleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.trainingDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCustomCell", for: indexPath) as? DateCollectionViewCell
        let cellViewModel = viewModel.getDayCellViewModel(indexPath.row)
        cell?.configure(viewModel: cellViewModel)
        return cell ?? UICollectionViewCell()
    }
}

//MARK: - UITableViewDelegate
extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "goToDetailsScreen", sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

//MARK: - UITableViewDataSource
extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.trainingHoursCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCustomCell", for: indexPath) as? ScheduleTableViewCell
        let cellViewModel = viewModel.getTrainingCellViewModel(indexPath.row)
        cell?.configure(cellViewModel)
        return cell ?? UITableViewCell()
    }
}
