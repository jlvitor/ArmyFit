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

protocol PasswordValidationDelegate {
    func successPasswordValidation()
    func errorPasswordValidation()
}

class RegisterViewModel {
    
    //MARK: - Private properti
    private let service: UserService = .init()
    
    //MARK: - Public properties
    var delegate: RegisterViewModelDelegate?
    var validationDelegate: PasswordValidationDelegate?
    
    //MARK: - Public methods
    func makeRegisterRequest(_ name: String?, _ email: String?, _ password: String?) {
        service.registerUser(
            name: getValueToValidade(name),
            email: getValueToValidade(email),
            password: getValueToValidade(password)) { _, error in
                if error != nil {
                    self.delegate?.errorRegister()
                } else {
                    self.delegate?.successRegister()
                }
            }
    }
    
    func getPasswordValidation(_ password: String?, _ confirmPassword: String?) {
        guard let password = password,
              let confirmPassword = confirmPassword else { return }
        
        if password != confirmPassword {
            self.validationDelegate?.errorPasswordValidation()
        } else {
            self.validationDelegate?.successPasswordValidation()
        }
    }
    
    //MARK: - Private method
    private func getValueToValidade(_ text: String?) -> String {
        guard let text = text else { return "" }
        return text
    }
}
