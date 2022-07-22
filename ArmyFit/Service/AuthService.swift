//
//  AuthService.swift
//  ArmyFit
//
//  Created by Gabriel Policastro on 13/06/22.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FacebookLogin

class AuthService {
    
    private let baseUrl = "https://armyapi.herokuapp.com"
    
    // Registra o usuário no app/ bando de dados do app
    func registerUser(name: String, email: String, password: String, photoUrl: String? ,completion: @escaping (UserDTO?, Error?) -> Void) {
        guard let url = URL(string: "\(baseUrl)/users") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: String] = [
            "name": name,
            "email": email,
            "photoUrl": photoUrl ?? "https://storage.googleapis.com/armyfit/profile.png",
            "password": password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let register = try JSONDecoder().decode(UserDTO.self, from: data)
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
    
    // Valida o usuario para poder logar no app
    func authUser(email: String, password:  String, completion:  @escaping (Authentication?, Error?) -> Void) {
        guard let url = URL(string: "\(baseUrl)/login") else { return }
        
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
                let auth = try JSONDecoder().decode(Authentication.self, from: data)
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
    
    func saveUserOnFirebase(with credential: AuthCredential) {
        Auth.auth().signIn(with: credential)
    }
    
    // Start Google Signin
    func getGoogleCredential(from user: GIDGoogleUser?) -> AuthCredential? {
        guard let authentication = user?.authentication,
              let idToken = authentication.idToken else { return nil }

        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: authentication.accessToken)
        
        return credential
    }
    
    func getGoogleConfig() -> GIDConfiguration? {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return nil }
        let config = GIDConfiguration(clientID: clientID)
        
        return config
    }
    
    // Start Facebook Login
    func handleFacebookLoginResult(with result: LoginManagerLoginResult?, error: Error?) {
        
        switch result {
        case .none:
            print("Erro ao fazer login")
        case .some(let loginResult):
            guard let token = loginResult.token?.tokenString else { return }
            
            let credential = getFacebookConfig(with: token)
            saveUserOnFirebase(with: credential)
        }
    }
    
    func getFacebookConfig(with token: String) -> AuthCredential {
        return FacebookAuthProvider.credential(withAccessToken: token)
    }
    
    func loadUserImageFrom(_ imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                CoreDataService.shared.saveImageOnCoreData(sampleImageData: data)
            }
        }
        task.resume()
    }
}
