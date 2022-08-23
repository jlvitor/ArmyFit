//
//  UITextField+Extension.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 23/08/22.
//

import Foundation
import UIKit

private let button = UIButton(type: .custom)

extension UITextField {
    
    func enablePasswordToggle(){
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        button.tintColor = .black.withAlphaComponent(0.4)
        rightView = button
        rightViewMode = .always
    }
    
    @objc private func togglePasswordView(_ sender: Any) {
        isSecureTextEntry.toggle()
        button.isSelected.toggle()
    }
}
