//
//  PostsViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 17/06/22.
//

import Foundation

protocol PostViewModelDelegate {
    func reloadData()
}

protocol LikeAPostDelegate {
    func likeSuccess()
}

class PostsViewModel {
    
    //MARK: - Private propertie
    private let service: PostService = .init()
    
    //MARK: - Public properties
    var delegate: PostViewModelDelegate?
    var likeDelegate: LikeAPostDelegate?
    var postsList: [Post] = []
    
    //MARK: - Getters
    var getNumberOfPosts: Int {
        postsList.count
    }
    
    var getUserImage: String {
        UserDefaults.getValue(key: UserDefaults.Keys.userPhoto) as? String ?? "profile"
    }
    
    //MARK: - Public methods
    func getPosts() {
        service.getAllPosts { post, error in
            guard let post = post else { return }
            
            self.postsList = post
            self.delegate?.reloadData()
        }
    }
    
    func likeAPost(index: Int) {
        service.likePost(postId: postsList[index].id) { _, error in
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
            self.likeDelegate?.likeSuccess()
        }
    }
    
    func getPostCellViewModel(_ index: Int) -> PostViewModel {
        let post = postsList[index]
        return PostViewModel(post)
    }
    
    func getPostDetail(at index: Int?) -> CommentsViewModel? {
        guard let index = index else { return nil }
        
        let post = postsList[index]
        return CommentsViewModel(post: post)
    }
}
