//
//  ScheduleDetailTableViewCell.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 30/05/22.
//

import UIKit

class ScheduleDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var posterUser: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    func configure(_ viewModel: ScheduleDetailViewModel) {
        posterUser.image = UIImage(named: viewModel.getUserImage())
        userNameLabel.text = viewModel.getUserName()
    }    
}
    
   
      


   

