//
//  RegisterViewModel.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 14/06/22.
//

import Foundation

protocol RegisterViewModelDelegate {
    
    func successRegister()
    func errorRegister()
    }

class RegisterViewModel {
    
    private let service: UserService
    
    var delegate: RegisterViewModelDelegate?
    
    init(service: UserService = .init()) {
        self.service = service
    }
    
 func getValueToValidade(_ text: String?) -> String {
    guard let text = text else { return "" }
    return text
}

    func makeRegisterRequest(_ name: String?, _ email: String?, _ password: String?) {
        service.registerUser(
            name: getValueToValidade(name),
            email: getValueToValidade(email),
            password: getValueToValidade(password)) { success, error in
                guard let success = success else {
                    self.delegate?.errorRegister()
                    return
                }
                print(success)
                self.delegate?.successRegister()
            
            }
    }
    
}

//func makeLoginRequest(_ email: String?, _ password: String?) {
//    service.makeAuthPostRequest(
//        email: getValueToValidade(email),
//        password: getValueToValidade(password)) { success, error in
//            guard let success = success else {
//                self.delegate?.errorAuth()
//                return
//            }
//            self.userAuth = success
//            self.delegate?.successAuth()
//        }
//}
