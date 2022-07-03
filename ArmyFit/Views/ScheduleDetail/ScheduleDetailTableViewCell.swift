//
//  ScheduleDetailTableViewCell.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 30/05/22.
//

import UIKit

class ScheduleDetailTableViewCell: UITableViewCell {

    //MARK: - Private properties
    @IBOutlet private weak var posterUser: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    
    //MARK: - Punlic method
    func configure(_ index: Int, _ viewModel: RegisterTrainingViewModel) {
        posterUser.image = UIImage(named: viewModel.getUserImage(index))
        userNameLabel.text = viewModel.getUserName(index)
    }    
}
    
   
      


   

