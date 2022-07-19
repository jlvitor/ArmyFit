//
//  String+Extension.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 15/06/22.
//

import Foundation

extension String.StringInterpolation {
    
    mutating func appendInterpolation<T: CustomStringConvertible>(_ value: T?) {
        appendInterpolation(value ?? "nil" as CustomStringConvertible)
    }
}
