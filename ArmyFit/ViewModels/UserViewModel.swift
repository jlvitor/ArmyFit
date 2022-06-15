//
//  UserViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 05/06/22.
//

import Foundation

protocol UserViewModelDelegate {
    func successRequest()
    func errorRequest()
}

class UserVideModel {
    
    private let service: UserService = UserService()
    private var userData: User?
    var delegate: UserViewModelDelegate?
    
    func fetchUserData() {
//        service.getUserFromJson(fromFileNamed: "user") { success, error in
//            guard let success = success else {
//                self.delegate?.errorRequest()
//                return
//            }
//            self.userData = success
//            self.delegate?.successRequest()
//        }
    }
    
    func getUserImage() -> String {
        guard let image = userData?.photoUrl else { return ""}
        return image
    }
    
    func getName() -> String {
        guard let name = userData?.name else { return ""}
        return name.uppercased()
    }
}
