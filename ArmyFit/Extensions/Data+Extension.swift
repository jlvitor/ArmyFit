//
//  Data+Extension.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 26/06/22.
//

import Foundation

extension Data {
   mutating func append(_ string: String) {
      if let data = string.data(using: .utf8) {
         append(data)
         print("data======>>>", data)
      }
   }
}
