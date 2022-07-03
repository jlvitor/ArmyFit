//
//  ProfileTableViewCell.swift
//  ArmyFit
//
//  Created by Gabriel Policastro on 05/06/22.
//

import UIKit

struct ProfileCellViewModel {
    let icon: UIImage?
    let label: String
}

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var cellImageView: UIImageView!
    @IBOutlet private weak var cellLabel: UILabel!
    
    func configure(profileCellViewModel: ProfileCellViewModel) {
        cellImageView.image = profileCellViewModel.icon
        cellLabel.text = profileCellViewModel.label
    }
}
