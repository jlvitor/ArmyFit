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

class PostsViewModel {
    
    private let service: PostService
    
    var delegate: PostViewModelDelegate?
    var postsList: [Post] = []
    var numberOfPosts: Int = 0
    var getUserImage: String {
        guard let userImage = UserDefaults.getValue(key: UserDefaults.Keys.userPhoto) as? String else { return "profile"}
        return userImage
    }
    
    init(service: PostService = .init()) {
        self.service = service
    }
    
    func getPosts() {
        service.getPost { post, error in
            guard let post = post else { return }

            self.numberOfPosts = post.count
            self.postsList = post
            self.delegate?.reloadData()
        }
    }
    
    func getPostCellViewModel(_ index: Int) -> PostViewModel {
        let post = postsList[index]
        return PostViewModel(post)
    }
    
}
