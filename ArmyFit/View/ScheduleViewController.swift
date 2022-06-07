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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableViewAndCollectionView()
    }
    
    private func configTableViewAndCollectionView() {
        dateCollectionView.dataSource = self
        dateCollectionView.delegate = self
        
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        scheduleTableView.overrideUserInterfaceStyle = .dark
    }
}


//MARK: - UICollectionViewDelegate
extension ScheduleViewController: UICollectionViewDelegate {
    
}

//MARK: - UITableViewDelegate
extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let exerciseSelected = tableView.indexPathForSelectedRow?.row else { return }

        performSegue(withIdentifier: "goToDetailsScreen", sender: exerciseSelected)
        tableView.deselectRow(at: indexPath, animated: true)
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

//MARK: - UICollectionViewDataSource
extension ScheduleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCustomCell", for: indexPath) as? DateCollectionViewCell
        cell?.dateTextLabel.text = "SEG"
        cell?.dateNumberLabel.text = "18"
        return cell ?? UICollectionViewCell()
    }
}

//MARK: - UITableViewDataSource
extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCustomCell", for: indexPath) as? ScheduleTableViewCell
        cell?.houerLabel.text = "05"
        cell?.minuteLabel.text = "00"
        cell?.exerciseTitleLabel.text = "CROSSFIT"
        cell?.coachLabel.text = "FERNANDA"
        return cell ?? UITableViewCell()
    }
}
