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
    
    public func alertIsEmptyTextField(title: String, message: String, completion: (() -> Void)? = nil) {
    let emptyAlert = UIAlertController(
        title: title,
        message: message,
        preferredStyle: .alert
    )
    let okAction = UIAlertAction(
        title: "Ok",
        style: .default) { action in
            completion?()
        }
    
    emptyAlert.addAction(okAction)
    
    self.controller.present(emptyAlert, animated: true, completion: nil)
}
    public func alertIsEqualPassword(title: String, message: String, completion: (() -> Void)? = nil) {
    let equalAlert = UIAlertController(
        title: title,
        message: message,
        preferredStyle: .alert
    )
    let okAction = UIAlertAction(
        title: "Ok",
        style: .default) { action in
            completion?()
        }
    
    equalAlert.addAction(okAction)
    
    self.controller.present(equalAlert, animated: true, completion: nil)
    
}
    public func alertIsValidEmail(title: String, message: String, completion: (() -> Void)? = nil) {
    let validAlert = UIAlertController(
        title: title,
        message: message,
        preferredStyle: .alert
    )
    let okAction = UIAlertAction(
        title: "Ok",
        style: .default) { action in
            completion?()
        }
    
    validAlert.addAction(okAction)
    
    self.controller.present(validAlert, animated: true, completion: nil)
    
    }
    
}

// Campos em branco
// Senha = confirmar senha
// Email é valido
// Senha é válida

