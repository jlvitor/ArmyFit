//
//  User.swift
//  ArmyFit
//
//  Created by Marcelo Falcao Costa Filho on 30/05/22.
//

import Foundation


struct User {
    var email: String
    var password: String
    let name: String
    var confirmPassword: Bool
    var posterUser: String?
    var dayTrainingParticipation: Bool = false
    // se ele vai participar do treino ou nao
    var anualCheckInNumber: Int = 0
    // quantos check-ins ele fez no ano
    var numberOfActivitiesDone: Int = 0
    // número de atividades feitas
    var userPublicationFeed: [String] = []
    // Publicações do usuário no Feed
}
    

