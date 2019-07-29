//
//  carros.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 22/03/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import Foundation


class Carro : Codable {
    
    var id = 0
    var nome = ""
    var descricao = ""
    var marca =  ""
    var quantidade = 0
    var preco = 0.0
    var imagem = ""
    var shopQuant: Int?
}
