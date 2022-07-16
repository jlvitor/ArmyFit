//
//  Password+Extension.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 14/07/22.
//

import Foundation

extension String {
    
    static func passwordGenerator() -> String {
        let len = 8
        let pswdChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        let rndPswd = String((0..<len).compactMap{ _ in pswdChars.randomElement() })
        
        return rndPswd
    }
    
}
