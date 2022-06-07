//
//  UserViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 05/06/22.
//

import Foundation

protocol UserVideModelDelegate {
    func successRequest()
    func errorRequest()
}

class UserVideModel {
    
    private let service: Service = Service()
    private var userData: User?
    var delegate: UserVideModelDelegate?
    
    func fetchUserData() {
        service.getUserFromJson(fromFileNamed: "user") { success, error in
            guard let _success = success else {
                self.delegate?.errorRequest()
                return
            }
            self.userData = _success
            self.delegate?.successRequest()
        }
    }
    
    func getUserImage() -> String {
        guard let image = userData?.photoURL else { return ""}
        return image
    }
    
    func getName() -> String {
        guard let name = userData?.name else { return ""}
        return name.uppercased()
    }    
}
