//
//  ValidationAlerts+Extension.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 18/06/22.
//

import Foundation
import UIKit

class Alert {
    
    private var controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
     public func getAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "Ok",
            style: .default) { action in
                completion?()
            }
        
        alert.addAction(okAction)
        
        self.controller.present(alert, animated: true, completion: nil)
    }
}

//if name == "" || email == "" || password == "" {
//    ErrorAlertsTextfield().alertTextField(
//        vc: self,
//        title: "Erro",
//        message: "Por favor preencha todos os campos")
//} else if password != confirmPassword {
//    ErrorAlertsTextfield().alertTextField(
//        vc: self,
//        title: "Erro",
//        message: "Por favor digite a mesma senha nos dois campos")
//} else {
//    if !email.isValidEmail(email: email) {
//        ErrorAlertsTextfield().alertTextField(vc: self, title: "Opa!", message: "Por favor coloque um email válido")
//    }
//    else if !password.isValidPassword(password: password) {
//        ErrorAlertsTextfield().alertTextField(vc: self, title: "Opa!", message: "Por favor coloque uma senha válida")
//
//    } else {
//        performSegue(withIdentifier: "backToLoginScreen", sender: self)
//    }
//}
