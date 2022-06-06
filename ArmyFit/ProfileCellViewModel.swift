//
//  ProfileCellViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 05/06/22.
//

import Foundation
 
class ProfileCellViewModel {
    
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


//    func setImageCell(_ indexPath: IndexPath) -> String? {
//        let _section = indexPath.section
//
//        switch _section {
//        case 0:
//            return "calendar"
//        case 1:
//            return "envelope.fill"
//        case 2:
//            return "iphone.and.arrow.forward"
//        default:
//            break
//        }
//        return ""
//    }
//
//    func setLabelCell(_ indexPath: IndexPath) -> String? {
//        let _section = indexPath.section
//
//        switch _section {
//        case 0:
//            return "Treinos agendados: 11"
//        case 1:
//            return "WhatsApp"
//        case 2:
//            return "Sair"
//        default:
//            break
//        }
//        return ""
//    }
