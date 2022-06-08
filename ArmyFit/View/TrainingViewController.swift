//
//  TrainingViewController.swift
//  ArmyFit
//
//  Created by Gabriel Policastro on 08/06/22.
//

import UIKit

class TrainingViewController: UIViewController {

    @IBOutlet weak var trainingTableView: UITableView!
    
    private var viewModel: TrainingViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()

    }
    
    private func configTableView() {
        trainingTableView.dataSource = self
    }
    

}
extension TrainingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = viewModel?.countRowsInSection(section) else { return 0 }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as? TrainingTableViewCell
        let section = indexPath.section
        let row = indexPath.row
        if let cellViewModel = viewModel?.setTraining(at: section, at: row) {
            cell?.configure(viewModel: cellViewModel)
            return cell ?? UITableViewCell()
        }
         
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let title = viewModel?.setTitleForSection(section) else { return "" }
        return title
    }
}
