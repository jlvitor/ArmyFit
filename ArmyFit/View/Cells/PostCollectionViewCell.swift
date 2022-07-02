//
//  PostCollectionViewCell.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 17/06/22.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var buttonsStackView: UIStackView!
    
    func configure(_ viewModel: PostViewModel) {
        userImageView.image = UIImage(named: viewModel.getUserImage())
        userNameLabel.text = viewModel.getUserName()
        postLabel.text = viewModel.getPostText()
        numberOfLikesLabel.text = viewModel.getNumberOfLikes()
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        let scaleConfig = UIImage.SymbolConfiguration(scale: .small)
        
        if likeButton.tag == 0 {
            likeButton.setImage(UIImage(systemName: "hand.thumbsup")?.withConfiguration(scaleConfig), for: .normal)
            likeButton.tintColor = UIColor(named: "green_color")
            likeButton.tag = 1
        } else {
            likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill")?.withConfiguration(scaleConfig), for: .normal)
            likeButton.tintColor = UIColor(named: "green_color")
            likeButton.tag = 0
        }
    }
}

