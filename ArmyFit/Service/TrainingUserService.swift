//
//  TrainingUserService.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 07/06/22.
//

import Foundation

// Define uma enumeracao chamada Error do tipo protocolo Error
enum TrainingUserError: Swift.Error {
    // Valor fileNotFound com um valor associado chamando name do tipo String
    case fileNotFound(_ name: String)
    // Valor fileDecodingFailed com dois valores associados, um do tipo String e outro do tipo protocolo Error
    case fileDecodingFailed(_ name: String, Swift.Error)
}

protocol TrainingUserServiceDelegate {
    func getTrainingUsersFromJson(fromFileNamed name: String, completion: @escaping (_ result: TrainingUser?, _ failure: Error?) -> Void)
}

class TrainingUserService: TrainingUserServiceDelegate {
    // Esse metodo vai buscar todos os treinos em um arquivo json
    func getTrainingUsersFromJson(fromFileNamed name: String, completion: @escaping (TrainingUser?, Error?) -> Void) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            // caso o arquivo não seja encontro é retornado uma mensagem informando que o arquivo de nome "training" nao foi encontrado
            return completion(nil, TrainingUserError.fileNotFound(name))
        }
        
        do {
            let data = try Data(contentsOf: url) // Tras os dados a partir da url e salva no data
            let trainingUsers = try JSONDecoder().decode(TrainingUser.self, from: data) // Decodifica o data atraves do tipo (modelo) fornecido
            completion(trainingUsers, nil) // Se der tudo certo o completion vai levar os dados do treino adiante, sem nenhum erro
        } catch {
            // Se der errado o completion nao retorna nenhum dado do treino, e sim uma mensagem informando que o arquivo falhou em ser decodificado
            completion(nil, TrainingUserError.fileDecodingFailed(name, error))
        }
    }
}
