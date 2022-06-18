//
//  ValidationAlerts+Extension.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 18/06/22.
//

import Foundation
import UIKit

class ErrorAlertsTextfield: NSObject {
    
    func alertTextField(
        vc: UIViewController,
        title: String,
        message: String) {
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: "Ok",
            style: .default,
            handler: nil
        )
        
        alert.addAction(okAction)
        
        vc.present(alert, animated: true, completion: nil)
    }
}
