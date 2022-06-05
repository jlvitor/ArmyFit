//
//  Service.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 03/06/22.
//

import Foundation

// Define uma enumeracao chamada Error do tipo protocolo Error
enum Error: Swift.Error {
    // Valor fileNotFound com um valor associado chamando name do tipo String
    case fileNotFound(_ name: String)
    // Valor fileDecodingFailed com dois valores associados, um do tipo String e outro do tipo protocolo Error
    case fileDecodingFailed(_ name: String, Swift.Error)
}

protocol ServiceDelegate {
    func getUserFromJson(fromFileNamed name: String, completion: @escaping (_ result: User?, _ failure: Error?) -> Void)
    func getTrainingFromJson(fromFileNamed name: String, completion: @escaping (_ result: Training?, _ failure: Error?) -> Void)
}

class Service: ServiceDelegate {
    // Esse metodo vai buscar todos os usuários em um arquivo json
    func getUserFromJson(fromFileNamed name: String, completion: @escaping (User?, Error?) -> Void) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            // caso o arquivo não seja encontro é retornado uma mensagem informando que o arquivo de nome "user" nao foi encontrado
            return completion(nil, Error.fileNotFound(name))
        }
        
        do {
            let data = try Data(contentsOf: url) // Tras os dados a partir da url e salva no data
            let user = try JSONDecoder().decode(User.self, from: data) // Decodifica o data atraves do tipo (modelo) fornecido
            completion(user, nil) // Se der tudo certo o completion vai levar os dados do usuário adiante, sem nenhum erro
        } catch {
            // Se der errado o completion nao retorna nenhum dado do usuario, e sim uma mensagem informando que o arquivo falhou em ser decodificado
            completion(nil, Error.fileDecodingFailed(name, error))
        }
    }
    
    // Esse metodo vai buscar todos os treinos em um arquivo json
    func getTrainingFromJson(fromFileNamed name: String, completion: @escaping (Training?, Error?) -> Void) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            // caso o arquivo não seja encontro é retornado uma mensagem informando que o arquivo de nome "training" nao foi encontrado
            return completion(nil, Error.fileNotFound(name))
        }
        
        do {
            let data = try Data(contentsOf: url) // Tras os dados a partir da url e salva no data
            let training = try JSONDecoder().decode(Training.self, from: data) // Decodifica o data atraves do tipo (modelo) fornecido
            completion(training, nil) // Se der tudo certo o completion vai levar os dados do treino adiante, sem nenhum erro
        } catch {
            // Se der errado o completion nao retorna nenhum dado do treino, e sim uma mensagem informando que o arquivo falhou em ser decodificado
            completion(nil, Error.fileDecodingFailed(name, error))
        }
    }
}
