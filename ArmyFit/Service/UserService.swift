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
    
    //MARK: - Registra o usuário no app/ bando de dados do app
    func registerUser(name: String, email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        guard let url = URL(string: baseUrl) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: String] = [
            "name": name,
            "email": email,
            "password": password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let register = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    completion(register, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    //MARK: - Atualiza nome e foto do usuário
    func updateUser(name: String, photoURL: String, completion: @escaping (User?, Error?) -> Void) {
        guard let url = URL(string: baseUrl) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer\(keychain.get("token"))", forHTTPHeaderField: "Authorization")
        let body: [String: String] = [
            "name": name,
            "photoURL": photoURL
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }

            do {
                let update = try JSONDecoder().decode(User.self, from: data)
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
    
    func getUserDetails(completion: @escaping (User?, Error?) -> Void) {
        guard let url = URL(string: "\(baseUrl)/profile") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(keychain.get("token"))", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    completion(user, nil)
                }
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
