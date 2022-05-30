//
//  Schedule.swift
//  ArmyFit
//
//  Created by Marcelo Falcao Costa Filho on 30/05/22.
//

import Foundation

struct Schedule {
    var treino: [Trainer]
}

struct Trainer {
    var horario: Date
    var nomeDeTreino: String
    var nomeDoCoach: String
    var quantidadeDeVagas: Int
}
