//
//  PostCollectionViewCell.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 17/06/22.
//

import UIKit
import Kingfisher

class PostCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Private properties
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var postDateLabel: UILabel!
    @IBOutlet private weak var postLabel: UILabel!
    @IBOutlet private weak var numberOfLikesLabel: UILabel!
    @IBOutlet private weak var numberOfCommentsLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    private var sharedText: String?
    
    //MARK: - Public propertie
    var sharedAction: ((String) -> Void)?
    var delegate: ButtonPressedDelegate?
        
    //MARK: - Public method
    func configure(_ viewModel: PostViewModel) {
        userImageView.kf.setImage(with: URL(string: viewModel.getUserImage))
        userNameLabel.text = viewModel.getUserName
        postLabel.text = viewModel.getPostText
        numberOfLikesLabel.text = viewModel.getNumberOfLikes
        numberOfCommentsLabel.text = viewModel.getNumberOfComments
        sharedText = viewModel.getPostText
    }
    
    //MARK: - Private method
    @IBAction private func sharedButtonAction(_ sender: UIButton) {
        guard let sharedText = sharedText else { return }
        sharedAction?(sharedText)
    }
    
    @IBAction func likeButtonAction(_ sender: UIButton) {
        let scaleConfig = UIImage.SymbolConfiguration(scale: .small)
        
//        if likeButton.tag == 0 {
//            likeButton.setImage(UIImage(systemName: "hand.thumbsup")?.withConfiguration(scaleConfig), for: .normal)
//            likeButton.tintColor = UIColor(named: "green_color")
//            likeButton.tag = 1
//        } else {
//            likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill")?.withConfiguration(scaleConfig), for: .normal)
//            likeButton.tintColor = UIColor(named: "green_color")
//            likeButton.tag = 0
//        }
        print(sender.tag)
        delegate?.likeButton(sender: sender.tag)
    }
    
    @IBAction func commentButtonAction(_ sender: UIButton) {
        delegate?.commentButton()
    }
}

