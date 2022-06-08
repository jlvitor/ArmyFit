//
//  ProfileViewController.swift
//  ArmyFit
//
//  Created by Gabriel Policastro on 05/06/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    
    private let viewModel: UserVideModel = UserVideModel()
    private let cellViewModel: ProfileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewModel()
        configUserImage()
        configTableView()
    }
    
    private func configTableView() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
    }
    
    private func configViewModel() {
        viewModel.delegate = self
        viewModel.fetchUserData()
    }
    
    private func configUserImage() {
        profileImageView.layer.borderWidth = 5
        profileImageView.layer.borderColor = UIColor(named: "Background 2")?.cgColor
    }
    
    @IBAction func logoutButtonAction(_ sender: UIButton) {
    }
}

//MARK: - UserVideModelDelegate
extension ProfileViewController: UserViewModelDelegate {
    func successRequest() {
        profileImageView.image = UIImage(named: viewModel.getUserImage())
        nameLabel.text = viewModel.getName()
    }
    
    func errorRequest() {
        print("Erro ao carregar os dados do usuário")
    }
}

//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

//MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModel.countRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCustomCell", for: indexPath) as? ProfileTableViewCell
        let section = indexPath.section
        let row = indexPath.row
        let _cellViewModel = cellViewModel.profileInfo(at: section, at: row)
        
        cell?.configure(profileCellViewModel: _cellViewModel)
        
        return cell ?? UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = cellViewModel.setTilteForSection(section)
        return title
    }
}
