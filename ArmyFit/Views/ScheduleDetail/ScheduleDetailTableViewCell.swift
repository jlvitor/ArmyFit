//
//  ScheduleDetailTableViewCell.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 30/05/22.
//

import UIKit
import Kingfisher

class ScheduleDetailTableViewCell: UITableViewCell {

    //MARK: - Private properties
    @IBOutlet private weak var posterUser: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    
    //MARK: - Punlic method
    func configure(_ index: Int, _ viewModel: RegisterTrainingViewModel) {
        posterUser.kf.setImage(with: URL(string: viewModel.getUserImage(index)))
        userNameLabel.text = viewModel.getUserName(index)
    }    
}
    
   
      


   

