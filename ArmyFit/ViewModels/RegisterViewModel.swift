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

protocol ValidationTextFieldsDelegate {
    func successValidation()
    func errorValidation()
    func isEmptyTextField()
    func isEqualPassword()
    func isValidEmailValidation()
}

class RegisterViewModel {
    
    private let service: UserService
    
    var delegate: RegisterViewModelDelegate?
    var validationDelegate: ValidationTextFieldsDelegate?
    
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
    
//    func validationTextFields(_ name: String?, _ email: String?, _ password: String?, _ confirmPassword: String?) {
//        guard let name = name,
//              let email = email,
//              let password = password,
//              let confirmPassword = confirmPassword else {
//                  validationDelegate?.errorValidation()
//                  return }
//
//        }
    
    func isEqualPassword(_ password: String, _ confirmPassword: String) -> Bool {
        if password != confirmPassword {
            return false
            validationDelegate?.errorValidation()
        }
            return  String.isValidPassword(password: password)
            validationDelegate?.successValidation()
    }
    
    func isValidEmailRegister(_ email: String?) {
        guard let email = email else { return }
        let validEmail = String.isValidEmail(email: email)
        if validEmail {
            validationDelegate?.successValidation()
        }
            validationDelegate?.errorValidation()
        
    }
    
    func isEmptyTextField(_ name: String?, _ email: String?, _ password: String?, _ confirmPassword: String?)  {
        if let name = name,
           let email = email,
           let password = password,
           let confirmPassword = confirmPassword {
        
            if name == "" || email == "" || password == "" || confirmPassword == "" {
                validationDelegate?.errorValidation()
            }
                validationDelegate?.successValidation()
        }
    }
}

    
    
    
    

