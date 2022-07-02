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
    
    private let service: UserService
    
    var delegate: RegisterViewModelDelegate?
    var validationDelegate: PasswordValidationDelegate?
    
    init(service: UserService = .init()) {
        self.service = service
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
    
    func getPasswordValidation(_ password: String?, _ confirmPassword: String?) {
        if let password = password,
           let confirmPassword = confirmPassword {
            if password != confirmPassword {
                self.validationDelegate?.errorPasswordValidation()
            } else {
                self.validationDelegate?.successPasswordValidation()
            }
        }
    }
    
    func getValueToValidade(_ text: String?) -> String {
        guard let text = text else { return "" }
        return text
    }
}
