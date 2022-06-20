//
//  EmailPasswordValidation+Extension.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 18/06/22.
//

import Foundation



//MARK: - Parâmetros de validação dos textfields com caractéres corretos
extension String {
    
    static func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let emailResult = emailTest.evaluate(with: email)
        return emailResult
    }
    
    static func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,10}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        let passwordResult = passwordTest.evaluate(with: password)
        return passwordResult
        
        // Senha com letras, 1 caractere especial, uma letra maiuscula e números opcionais
        // Mínimo 6 e máx 10 caracteres permitidos (Pode trocar {6,16}
        // email padrao xxxxx@yyyyy.com
    }
    
}
