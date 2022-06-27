//
//  UserService.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 06/06/22.
//

import Foundation
import KeychainSwift

class UserService {
    
    private let baseUrl = "https://armyapi.herokuapp.com"
    private let keychain: KeychainSwift = .init()
    
    //MARK: - Registra o usuário no app/ banco de dados do app
    func registerUser(name: String, email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        guard let url = URL(string: "\(baseUrl)/users") else { return }
        
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
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    //MARK: - Pega os detalhes do usuário
    func getUserDetails(completion: @escaping (User?, Error?) -> Void) {
        guard let url = URL(string: "\(baseUrl)/users/profile") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(keychain.get("token"))", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let userDetail = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    completion(userDetail, nil)
                }
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    //MARK: - Atualiza nome/ foto do usuário
    func updateUserName(name: String, photoUrl: URL, completion: @escaping (User?, Error?) -> Void) {
        guard let url = URL(string: "\(baseUrl)/users") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer\(keychain.get("token"))", forHTTPHeaderField: "Authorization")
        let body: [String: Any] = [
            "name": name,
            "photoUrl": photoUrl
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let updateUser = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    completion(updateUser, nil)
                }
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    //MARK: - Converte e envia a imagem para o servidor
    func uploadImageToServer(image: UIImage, completion: @escaping (MediaResponse?, Error?) -> Void) {
        let boundary = generateBoundary()
        
        guard let mediaImage = Media(withImage: image, forKey: "image") else { return }
        
        guard let url = URL(string: "\(baseUrl)/upload") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer\(keychain.get("token"))", forHTTPHeaderField: "Authorization")
        let dataBody = createDataBody(media: [mediaImage], boundary: boundary)
        request.httpBody = try? JSONSerialization.data(withJSONObject: dataBody, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else { return }

            do {
                let image = try JSONDecoder().decode(MediaResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(image, nil)
                }
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    private func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    private func createDataBody(media: [Media]?, boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        
        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.fileName)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        return body
    }
}
