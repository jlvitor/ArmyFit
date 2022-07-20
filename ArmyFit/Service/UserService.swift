//
//  UserService.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 06/06/22.
//

import Foundation
import KeychainSwift

class UserService {
    
    private let baseUrl = "https://armyapi.herokuapp.com/users"
    private let keychain: KeychainSwift = .init()
    
    // Atualiza nome do usuário
    func updateUserName(name: String, completion: @escaping (UserDTO?, Error?) -> Void) {
        guard let url = URL(string: baseUrl) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(keychain.get("token"))", forHTTPHeaderField: "Authorization")
        let body: [String: String] = [
            "name": name
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }

            do {
                let update = try JSONDecoder().decode(UserDTO.self, from: data)
                DispatchQueue.main.async {
                    completion(update, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
}
