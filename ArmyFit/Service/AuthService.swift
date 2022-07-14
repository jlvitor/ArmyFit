//
//  AuthService.swift
//  ArmyFit
//
//  Created by Gabriel Policastro on 13/06/22.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class AuthService {
    
    private let baseUrl = "https://armyapi.herokuapp.com/login"
    
    // Valida o usuario para poder logar no app
    func makeAuthPostRequest(email: String, password:  String, completion:  @escaping (Auth?, Error?) -> Void) {
        guard let url = URL(string: baseUrl) else { return }
        
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
    
    func loginWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

          if let error = error {
            // ...
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)

          // ...
        }
    }
}
