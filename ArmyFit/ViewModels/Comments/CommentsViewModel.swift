//
//  CommentsViewModel.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 18/07/22.
//

import Foundation
import UIKit

protocol CommentsViewModelDelegate {
    func reloadData()
}

class CommentsViewModel {
    
    private let service: PostService = .init()
    var delegate: CommentsViewModelDelegate?
    private var commentList: [CommentPost] = []
    
    func getNumberOfComments() -> Int {
        return commentList.count
    }
    
    func getComment(row: Int) -> CommentPost {
        return commentList[row]
    }
    
    func loadComments() {
        // Aqui deverá ter uma chamada para carregar todos os comentários de um post específico!
        self.delegate?.reloadData()
    }
    
    func createNewComment(comment: CommentPost) {
        // Aqui deve ser chamado um método do serviço para criar um novo comentário!!
        commentList.append(comment)
        loadComments()
    }
}
    
    
    
//    var getUserImage: String {
//        UserDefaults.getValue(key: UserDefaults.Keys.userPhoto) as? String ?? "profile"
//    }
//
//    var getUserName: String {
//            UserDefaults.getValue(key: UserDefaults.Keys.userName) as? String ?? "profile"
//        }
//
//
//    func getComments() {
//        service.commentPost(feedId: CommentPost.id, comment: CommentPost.comment) { <#[CommentPost]?#>, error in
//            guard let comment = comment else { return }
//            self.commentList = comment
//            self.delegate?.reloadData()
//        }
//}


    
    


        


