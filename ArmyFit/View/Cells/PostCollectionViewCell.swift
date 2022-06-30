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
        if likeButton.tag == 0 {
            likeButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
            likeButton.tag = 1
            likeButton.im
        } else {
            likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
            likeButton.tag = 0
            likeButton.titleLabel!.font = UIFont(name: "System", size: 14.0)
           
        }
    }
    }

