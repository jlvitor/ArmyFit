//
//  PostViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 17/06/22.
//

import Foundation

protocol ButtonPressedDelegate {
    func likeButton(sender: Int)
    func commentButton()
}

class PostViewModel {
    
    //MARK: - Private propertie
    private let post: Post
    
    //MARK: - Public propertie
    var delegate: ButtonPressedDelegate?
    
    init(_ post: Post) {
        self.post = post
    }
    
    //MARK: - Getters
    var getUserImage: String {
        post.user.photoUrl ?? "profile"
    }
    
    var getUserName: String {
        post.user.name.capitalized
    }
    
    var getPostText: String {
        post.description
    }
    
    var getNumberOfLikes: String {
        "\(post.like)"
    }
    
    var getNumberOfComments: String {
        "\(post.comments?.comments)"
    }
    
    var getPostId: String {
        post.id
    }
}
