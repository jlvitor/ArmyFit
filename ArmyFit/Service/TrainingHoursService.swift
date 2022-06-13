//
//  TrainingHoursSerice.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 07/06/22.
//

import Foundation

class TrainingHoursService {
    
    private let baseUrl = "https://armyapi.herokuapp.com/hours/2022-06-15"
      let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE2NTUwOTEzMjcsImV4cCI6MTY4NjY0ODkyNywic3ViIjoiMWMyMjNmNmMtMzBhMS00MzcyLWFjYTItMjc1NWYwNjg3ODhkIn0.0dxYt-RwScqNdF9OAR_BCIiF6JZfWsKiGK1zQMYuesA"
    
    //MARK: - Pega os treinos dos dias no mes atual
    func getTrainingHours(completion: @escaping ([TrainingHours]?, Error?) -> Void) {
        guard let url = URL(string: baseUrl) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer\(token)", forHTTPHeaderField: "Authorization")
        
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
}


