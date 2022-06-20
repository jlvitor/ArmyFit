//
//  LoginViewModel.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 13/06/22.
//

import Foundation
import KeychainSwift

protocol LoginViewModelDelegate {
    func successAuth()
    func errorAuth()
}

class LoginViewModel {
    
    private let service: AuthService
    private let keychain: KeychainSwift
    
    var delegate: LoginViewModelDelegate?
    
    init(service: AuthService = .init(), keychain: KeychainSwift = .init()) {
        self.service = service
        self.keychain = keychain
    }
    
    func makeLoginRequest(_ email: String?, _ password: String?) {
        service.makeAuthPostRequest(
            email: getValueToValidade(email),
            password: getValueToValidade(password)) { success, error in
                guard let success = success else {
                    self.delegate?.errorAuth()
                    return
                }
                
                self.keychain.set(success.token, forKey: "token", withAccess: .accessibleWhenUnlocked)
                UserDefaults.setValue(success.user.id, key: .userId)
                UserDefaults.setValue(success.user.name, key: .userName)
                UserDefaults.setValue(success.user.email, key: .userEmail)
                UserDefaults.setValue(success.user.photoUrl ?? "profile", key: .userPhoto)
                self.delegate?.successAuth()
            }
    }
    
    private func getValueToValidade(_ text: String?) -> String {
        guard let text = text else { return "" }
        return text
    }
}

