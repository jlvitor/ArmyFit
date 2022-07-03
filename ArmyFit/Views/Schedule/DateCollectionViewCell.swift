//
//  DateCollectionViewCell.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 27/05/22.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Private properties
    @IBOutlet private weak var dateView: UIView!
    @IBOutlet private weak var dateTextLabel: UILabel!
    @IBOutlet private weak var dateNumberLabel: UILabel!
    
    //MARK: - Public method
    func configure(viewModel: DayViewModel) {
        dateTextLabel.text = viewModel.getDayStringInAMonth
        dateNumberLabel.text = viewModel.getDayIntInAMonth
    }
}
