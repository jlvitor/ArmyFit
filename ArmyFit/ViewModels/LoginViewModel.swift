//
//  LoginViewModel.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 13/06/22.
//

import Foundation

protocol LoginViewModelDelegate {
    func successAuth()
    func errorAuth()
}

class LoginViewModel {
    
    private let service = AuthService()
    private var userAuth: Auth?
    
    var delegate: LoginViewModelDelegate?
    
    func makeLoginRequest(_ email: String?, _ password: String?) {
        service.makeAuthPostRequest(
            email: getValueToValidade(email),
            password: getValueToValidade(password)) { success, error in
                guard let success = success else {
                    self.delegate?.errorAuth()
                    return
                }
                self.userAuth = success
                self.delegate?.successAuth()
            }
    }
    
    private func getValueToValidade(_ text: String?) -> String {
        guard let text = text else { return "" }
        return text
    }
}

