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
        
        dateCollectionView.dataSource = self
        dateCollectionView.delegate = self
        
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
    }
}

extension ScheduleViewController: UICollectionViewDelegate {
   
}

extension ScheduleViewController: UITableViewDelegate {
    
}

extension ScheduleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCustomCell", for: indexPath) as? DateCollectionViewCell
        cell?.dateTextLabel.text = "SEG"
        cell?.dateNumberLabel.text = "18"
        return cell ?? UICollectionViewCell()
    }
    
    
}

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
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
