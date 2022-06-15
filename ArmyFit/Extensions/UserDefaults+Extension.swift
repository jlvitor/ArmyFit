//
//  UserDefaults+Extension.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 15/06/22.
//

import UIKit

extension UserDefaults {
    
    enum Keys: String, CaseIterable {
        case isLogged
        case userId
        case userName
        case userEmail
        case userPhoto
    }
    
    
    static func setValue(_ value: Any, key: Keys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func getValue(key: Keys) -> Any? {
        UserDefaults.standard.value(forKey: key.rawValue)
    }
    
    func resetAllValues() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue)}
    }
}
