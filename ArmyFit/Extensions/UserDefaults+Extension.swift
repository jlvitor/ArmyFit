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
    
    private static var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    static func setIsLogged(_ value: Bool) {
        userDefaults.set(value, forKey: Keys.isLogged.rawValue)
    }
    
    static func getIsLogged() -> Bool {
        userDefaults.bool(forKey: Keys.isLogged.rawValue)
    }
    
    static func setValue(_ value: Any, key: Keys) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    static func getValue(key: Keys) -> Any? {
        userDefaults.value(forKey: key.rawValue)
    }
    
    func resetAllValues() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue)}
    }
}
