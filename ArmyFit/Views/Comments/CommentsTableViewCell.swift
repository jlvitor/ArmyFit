//
//  CommentsTableViewCell.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 18/07/22.
//

import UIKit
import Kingfisher

class CommentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userCommentLabel: UILabel!
    
    func config(viewModel: CommentViewModel) {
        profileImage.kf.setImage(with: URL(string: viewModel.getUserImage))
        userNameLabel.text = viewModel.getUserName
        userCommentLabel.text = viewModel.getComment
    }

}
