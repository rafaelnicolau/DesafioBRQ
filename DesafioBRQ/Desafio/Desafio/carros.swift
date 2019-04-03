//
//  carros.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 22/03/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import Foundation


class Carro : Codable {
    
    var id: Int
    var nome: String
    var descricao: String
    var marca: String
    var quantidade: Int
    var preco: Double
    var imagem: String
}
