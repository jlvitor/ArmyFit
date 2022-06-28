//
//  NewPostViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 27/06/22.
//

import Foundation

protocol NewPostViewModelDelegate {
    func successMakeNewPost()
    func errorMakeNewPost()
}

class NewPostViewModel {
    
    private let service: PostService
    
    var delegate: NewPostViewModelDelegate?
    
    var getUserImage: String {
        guard let userImage = UserDefaults.getValue(key: UserDefaults.Keys.userPhoto) as? String else { return "profile"}
        return userImage
    }
    
    var getUserName: String {
        guard let userName = UserDefaults.getValue(key: UserDefaults.Keys.userName) as? String else { return "Usuário sem nome"}
        return userName
    }
    
    init(service: PostService = .init()) {
        self.service = service
    }
    
    func makeNewPost(description: String?) {
        guard let description = description else { return }

        service.makeNewPost(description: description) { _, error in
            if error != nil {
                self.delegate?.errorMakeNewPost()
                return
            }
            self.delegate?.successMakeNewPost()
        }
    }
}
