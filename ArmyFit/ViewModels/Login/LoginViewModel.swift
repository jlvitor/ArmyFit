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
    
    //MARK: - Private properties
    private let service: AuthService = .init()
    private let keychain: KeychainSwift = .init()
    
    //MARK: - Public propertie
    var delegate: LoginViewModelDelegate?
    
    //MARK: - Public method
    func makeLoginRequest(_ email: String?, _ password: String?) {
        service.makeAuthPostRequest(
            email: getValueToValidade(email),
            password: getValueToValidade(password)) { auth, error in
                guard let auth = auth else {
                    self.delegate?.errorAuth()
                    return
                }
                
                self.setKeychain(with: auth)
                self.loadUserImageFrom(auth.user.photoUrl)
                self.setUserDefaultsValues(with: auth)
                self.delegate?.successAuth()
            }
    }
    
    //MARK: - Private methods
    private func setKeychain(with auth: Auth) {
        keychain.set(auth.token, forKey: "token", withAccess: .accessibleWhenUnlocked)
    }
    
    private func setUserDefaultsValues(with auth: Auth) {
        UserDefaults.setIsLogged(true)
        UserDefaults.setValue(auth.user.id, key: .userId)
        UserDefaults.setValue(auth.user.name, key: .userName)
        UserDefaults.setValue(auth.user.email, key: .userEmail)
        UserDefaults.setValue(auth.user.photoUrl, key: .userPhoto)
    }
    
    private func loadUserImageFrom(_ imageUrl: String) {
        service.loadUserImageFrom(imageUrl)
    }
    
    private func getValueToValidade(_ text: String?) -> String {
        guard let text = text else { return "" }
        return text
    }
}

