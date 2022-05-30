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
    @IBOutlet weak var spacesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.dataSource = self
        
    }

    @IBAction func trainingParticipationButton(_ sender: UIButton) {
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
