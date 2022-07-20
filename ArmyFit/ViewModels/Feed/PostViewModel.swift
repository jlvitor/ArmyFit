//
//  PostViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 17/06/22.
//

import Foundation

class PostViewModel {
    
    //MARK: - Private propertie
    private let service: PostService = .init()
    private let post: Post
    
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
}
