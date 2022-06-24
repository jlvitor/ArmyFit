//
//  PostViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 17/06/22.
//

import Foundation

protocol PostLikeDelegate {
    func likeAPost(_ like: LikePost)
}

class PostViewModel {
    
    private let post: Post
    
    init(_ post: Post) {
        self.post = post
    }
    
    func getUserImage() -> String {
        guard let image = post.user.photoUrl else { return "person.circle"}
        return image
    }
    
    func getUserName() -> String {
        let name = post.user.name
        return name
    }
    
    func getPostText() -> String {
        let text = post.description
        return text
    }
    
    func getNumberOfLikes() -> String {
        let likes = post.like
        return "\(likes)"
    }    
}
