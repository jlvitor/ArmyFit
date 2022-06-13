//
//  AuthService.swift
//  ArmyFit
//
//  Created by Gabriel Policastro on 13/06/22.
//

import Foundation

class AuthService {
    
    private let baseURL = "https://armyapi.herokuapp.com/login"
    
    func makeAuthPostRequest(email: String, password:  String, completion:  @escaping (Auth?, Error?) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: String] = [
            "email": email,
            "password": password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let auth = try JSONDecoder().decode(Auth.self, from: data)
                DispatchQueue.main.async {
                    completion(auth, nil)
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
