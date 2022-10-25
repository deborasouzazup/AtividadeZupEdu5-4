//
//  Autor.swift
//  LearningTask-5.4
//
//  Created by Debora.souza on 25/10/22.
//

import Foundation

struct Autor {
    let fotoURI: String
    let nome: String
    let sobrenome: String
    let bio: String
    let tecnologia: String
    
    var nomeCompleto: String {
        return "\(nome) \(sobrenome)"
    }
    
    init(foto: String, nome: String, sobrenome: String, bio: String, tecologia: String) {
        self.fotoURI = foto
        self.nome = nome
        self.sobrenome = sobrenome
        self.bio = bio
        self.tecnologia = tecologia
    }
}
