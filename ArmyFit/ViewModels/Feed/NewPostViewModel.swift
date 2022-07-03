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
    
    //MARK: - Private propertie
    private let service: PostService = .init()
    
    //MARK: - Public propertie
    var delegate: NewPostViewModelDelegate?
    
    //MARK: - Getters
    var getUserImage: String {
        UserDefaults.getValue(key: UserDefaults.Keys.userPhoto) as? String ?? "profile"
    }
    
    var getUserName: String {
        UserDefaults.getValue(key: UserDefaults.Keys.userName) as? String ?? "Usuário sem nome"
    }
    
    //MARK: - Public method
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
