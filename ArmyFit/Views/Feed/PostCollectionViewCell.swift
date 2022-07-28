//
//  PostCollectionViewCell.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 17/06/22.
//

import UIKit
import Kingfisher
import AudioToolbox

class PostCollectionViewCell: UICollectionViewCell {
    
    var sharedAction: ((String) -> Void)?
    
    //MARK: - Private properties
    
    private var sharedText: String?
    
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var postDateLabel: UILabel!
    @IBOutlet private weak var postLabel: UILabel!
    @IBOutlet private weak var numberOfLikesLabel: UILabel!
    @IBOutlet private weak var numberOfCommentsLabel: UILabel!
    @IBOutlet private weak var commentsStackView: UIButton!
    
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var buttonsStackView: UIStackView!
        
    //MARK: - Public method
    func configure(_ viewModel: PostViewModel) {
        userImageView.kf.setImage(with: URL(string: viewModel.getUserImage))
        userNameLabel.text = viewModel.getUserName
        postLabel.text = viewModel.getPostText
        numberOfLikesLabel.text = viewModel.getNumberOfLikes
        sharedText = viewModel.getPostText
    }
    
    //MARK: - Private method
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
    
    @IBAction func sharedButtonPressed(_ sender: UIButton) {
        guard let sharedText = sharedText else {
            return
        }
        
        sharedAction?(sharedText)
    }
}

