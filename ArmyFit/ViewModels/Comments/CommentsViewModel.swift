//
//  CommentsViewModel.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 18/07/22.
//

import Foundation
import UIKit

protocol CommentsViewModelDelegate {
    func reloadTableView()
}

class CommentsViewModel {
    
    var delegate: CommentsViewModelDelegate?
    
    func getNumberOfComments() -> Int {
        return 5
    }
    
    
}


    
    


        


