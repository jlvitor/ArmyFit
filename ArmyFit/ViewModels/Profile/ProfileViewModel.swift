//
//  ProfileCellViewModel.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 05/06/22.
//

import Foundation
import UIKit

class ProfileViewModel {
    
    func getUserImage() -> String {
        guard let userImage = UserDefaults.getValue(key: UserDefaults.Keys.userPhoto) as? String else { return "profile2" }
        return userImage
    }
    
    func getUserName() -> String {
        guard let userName = UserDefaults.getValue(key: UserDefaults.Keys.userName) as? String else { return "Perfil sem nome" }
        return userName.uppercased()
    }
    
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
    
    func getWhatsApp() {
        let countryCode = "55" //Country code
        let mobileNumber = "81993704720" //Mobile number
        let urlString = "https://api.whatsapp.com/send?phone=\(countryCode)\(mobileNumber)"
        
        let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let URL = NSURL(string: urlStringEncoded!)
        
        if UIApplication.shared.canOpenURL(URL! as URL) {
            debugPrint("opening Whatsapp")
            UIApplication.shared.open(URL! as URL, options: [:]) { status in
                debugPrint("Opened WhatsApp Chat")
            }
        } else {
            debugPrint("Can't open")
        }
    }
    
    func createEmailUrl(to: String, subject: String) -> URL? {
              let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
              
              let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)")
              let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
              let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)")
              let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)")
              let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)")
              
              if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
                  return gmailUrl
              } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
                  return outlookUrl
              } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
                  return yahooMail
              } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
                  return sparkUrl
              }
              
              return defaultUrl
          }
}
