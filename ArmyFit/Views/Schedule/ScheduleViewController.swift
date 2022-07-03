//
//  ScheduleViewController.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 27/05/22.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    //MARK: - Private properties
    @IBOutlet private weak var dateCollectionView: UICollectionView!
    @IBOutlet private weak var scheduleTableView: UITableView!
    
    private let viewModel: SchedulesViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewModel()
        configCollectionView()
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let date = viewModel.date {
            viewModel.fetchTrainingsHours(date)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? ScheduleDetailViewController {
            let index = sender as? Int
            detailVC.viewModel = viewModel.getTrainingHoursDetail(index)
        }
    }
    
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
        viewModel.delegate = self
        viewModel.getRemainingDaysInAMonth()
        viewModel.fetchTrainingsHours(Date.getCurrentDateToDateString())
    }
}

//MARK: - UICollectionViewDelegate
extension ScheduleViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let day = viewModel.trainingDays[indexPath.item].0
        let date = viewModel.getDayStringToDateString(day: day)
        viewModel.fetchTrainingsHours(date)
        
        viewModel.cellSelected = indexPath.row
        viewModel.date = date
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDataSource
extension ScheduleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.trainingDays.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCustomCell", for: indexPath) as? DateCollectionViewCell else {
            return UICollectionViewCell()
        }
        let cellViewModel = viewModel.getDayCellViewModel(indexPath.row)
        
        cell.configure(viewModel: cellViewModel)
        viewModel.configCellBackgroundColorWhenSelected(cell, at: indexPath.row)
        
        return cell
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCustomCell", for: indexPath) as? ScheduleTableViewCell else {
            return UITableViewCell()
        }
        let cellViewModel = viewModel.getTrainingCellViewModel(indexPath.row)
        
        cell.configure(cellViewModel)
        
        return cell
    }
}

//MARK: - SchedulesViewModelDelegate
extension ScheduleViewController: SchedulesViewModelDelegate {
    func reloadData() {
        scheduleTableView.reloadData()
    }
}
