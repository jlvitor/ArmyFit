//
//  LoginViewModel.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 13/06/22.
//

import Foundation
import KeychainSwift
import GoogleSignIn
import FacebookLogin
import FacebookCore

protocol LoginViewModelDelegate {
    func successAuth()
    func errorAuth()
    func loginGoogle(with config: GIDConfiguration)
    func loginFacebook()
}

protocol GoogleLoginDelegate {
    func googleSuccess()
    func loginSuccess()
    func googleError()
    func loginError()
}

class LoginViewModel {
    
    //MARK: - Private properties
    private let service: AuthService = .init()
    private let keychain: KeychainSwift = .init()
    
    //MARK: - Public propertie
    var delegate: LoginViewModelDelegate?
    var googleDelegate: GoogleLoginDelegate?
    
    var userDTO: UserDTO?
    var googleUser: GIDGoogleUser = .init()
    var facebookUser: [String: Any] = [:]
    var randomPassword: String = ""
    
    //MARK: - Public method
    func makeLoginRequest(_ email: String?, _ password: String?) {
        service.authUser(
            email: getValueToValidade(email),
            password: getValueToValidade(password)) { auth, error in
                guard let auth = auth else {
                    self.delegate?.errorAuth()
                    return
                }
                
                self.setKeychain(with: auth)
                self.loadUserImageFrom(auth.user.photoUrl)
                self.setUserDefaultsValues(with: auth)
                self.delegate?.successAuth()
            }
    }
    
    func makeLoginGoogle() {
        guard let configuration = service.getGoogleConfig() else { return }
        
        delegate?.loginGoogle(with: configuration)
    }
    
    func makeLoginFacebook() {
        delegate?.loginFacebook()
    }
    
    func handleGoogleLogin(with user: GIDGoogleUser?, error: Error?) {
        if let error = error {
            print(error)
            return
        }
        
        guard let user = user else {
            googleDelegate?.googleError()
            return
        }
        
        googleUser = user
        randomPassword = String.passwordGenerator()
        googleDelegate?.googleSuccess()
        saveDataOnFirebase(with: user)
    }
    
    func handleFacebookLogin(with result: LoginManagerLoginResult?, error: Error?) {
        service.handleFacebookLoginResult(with: result, error: error)
        
        guard let token = result?.token?.tokenString else { return }
        
        let request = GraphRequest(
            graphPath: "me",
            parameters: ["fields": "name, email, picture"],
            tokenString: token,
            version: nil,
            httpMethod: .get)
        
        request.start { connection, result, error in
            guard let result = result else { return }
            
            print(result)
        }
    }
    
    func makeRegisterRequest(_ name: String, _ email: String, _ password: String, _ photoUrl: String?) {
        service.registerUser(
            name: name,
            email: email,
            password: getValueToValidade(password),
            photoUrl: photoUrl ?? "https://storage.googleapis.com/armyfit/profile.png") { _, error in
                if error != nil {
                    self.googleDelegate?.loginError()
                } else {
                    self.googleDelegate?.loginSuccess()
                }
            }
    }
    
    //MARK: - Private methods
    private func setKeychain(with auth: Authentication) {
        keychain.set(auth.token, forKey: "token", withAccess: .accessibleWhenUnlocked)
    }
    
    private func setUserDefaultsValues(with auth: Authentication) {
        UserDefaults.setIsLogged(true)
        UserDefaults.setValue(auth.user.id, key: .userId)
        UserDefaults.setValue(auth.user.name, key: .userName)
        UserDefaults.setValue(auth.user.email, key: .userEmail)
        UserDefaults.setValue(auth.user.photoUrl, key: .userPhoto)
    }
    
    private func loadUserImageFrom(_ imageUrl: String) {
        service.loadUserImageFrom(imageUrl)
    }
    
    private func getValueToValidade(_ text: String?) -> String {
        guard let text = text else { return "" }
        return text
    }
    
    private func saveDataOnFirebase(with user: GIDGoogleUser?) {
        guard let credential = service.getGoogleCredential(from: user) else { return }
        
        service.saveUserOnFirebase(with: credential)
    }
}

