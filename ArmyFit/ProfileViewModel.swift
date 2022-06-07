//
//  ProfileCellViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 05/06/22.
//

import Foundation
import UIKit

class ProfileViewModel {
    
    func countRowsInSection(_ section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 1
        default:
            break
        }
        return 0
    }
    
    func profileInfo(at section: Int, at row: Int) -> ProfileCellViewModel {
        switch section {
        case 0:
            return ProfileCellViewModel(icon: UIImage(systemName: "calendar.badge.clock"), label: "Treinos agendados: 11")
        case 1:
            if row == 0 {
                return ProfileCellViewModel(icon: UIImage(systemName: "envelope.fill"), label: "Email")
            } else {
                return ProfileCellViewModel(icon: UIImage(systemName: "phone.circle.fill"), label: "WhatsApp")
            }
        default:
            return ProfileCellViewModel(icon: UIImage(systemName: "iphone.and.arrow.forward"), label: "Sair")
        }
    }
    
    func setTilteForSection(_ section: Int) -> String? {
        switch section {
        case 0:
            return "Treinos"
        case 1:
            return "Entre em contato conosco"
        case 2:
            return "Logout"
        default:
            break
        }
        return nil
    }
}
