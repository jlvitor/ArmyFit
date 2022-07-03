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
    
    //MARK: - Private propertie
    private let service: PostService = .init()
    
    //MARK: - Public properties
    var delegate: PostViewModelDelegate?
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
        service.getPost { post, error in
            guard let post = post else { return }
            
            self.postsList = post
            self.delegate?.reloadData()
        }
    }
    
    func getPostCellViewModel(_ index: Int) -> PostViewModel {
        let post = postsList[index]
        return PostViewModel(post)
    }
}
