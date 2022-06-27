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
