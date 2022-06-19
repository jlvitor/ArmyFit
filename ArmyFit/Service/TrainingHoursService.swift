//
//  TrainingHoursSerice.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 07/06/22.
//

import Foundation
import KeychainSwift

class TrainingHoursService {
    
    private let baseUrl = "https://armyapi.herokuapp.com"
    private let keychain: KeychainSwift = .init()
    
    //MARK: - Pega os treinos dos dias no mes atual
    func getAllTrainingHours(_ date: String, completion: @escaping ([TrainingHours]?, Error?) -> Void) {
        guard let url = URL(string: "\(baseUrl)/hours/\(date)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(keychain.get("token"))", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let training = try JSONDecoder().decode([TrainingHours].self, from: data)
                DispatchQueue.main.async {
                    completion(training, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    func addUserOnTraining(_ userId: String, _ trainingHoursId: String, completion: @escaping (TrainingUser?, Error?) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)/trainingusers") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(keychain.get("token"))", forHTTPHeaderField: "Authorization")
        
        let body: [String: String] = [
            "trainingHoursId": trainingHoursId,
            "userId": userId
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let training = try JSONDecoder().decode(TrainingUser.self, from: data)
                DispatchQueue.main.async {
                    completion(training, nil)
                }
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}


