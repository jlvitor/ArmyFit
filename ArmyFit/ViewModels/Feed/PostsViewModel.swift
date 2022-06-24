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
    
    init(service: PostService = .init()) {
        self.service = service
    }
    
    func getPosts() {
        service.getPost { success, error in
            guard let success = success else { return }

            self.numberOfPosts = success.count
            self.postsList = success
            self.delegate?.reloadData()
        }
    }
    
    func getPostCellViewModel(_ index: Int) -> PostViewModel {
        let post = postsList[index]
        return PostViewModel(post)
    }
    
}
