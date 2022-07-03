//
//  DateCollectionViewCell.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 27/05/22.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateTextLabel: UILabel!
    @IBOutlet weak var dateNumberLabel: UILabel!
    
    func configure(viewModel: DayViewModel) {
        dateTextLabel.text = viewModel.getDayStringInAMonth()
        dateNumberLabel.text = viewModel.getDayIntInAMonth()
    }
    
}
