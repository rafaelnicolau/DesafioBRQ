//
//  CarViewData.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 16/08/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import Foundation

struct CarViewData {
    let id: Int
    let nome: String
    let descricao: String
    let marca: String
    let quantidade: Int
    let preco: Double
    let image: String
    let shopQuant: Int
    var favorite: Bool
}

// MARK - Domain Mapper -

extension CarViewData {
    init(carro: Carro){
        self.id = carro.id
        self.descricao = carro.descricao
        self.marca = carro.marca
        self.nome = carro.nome
        self.preco = carro.preco
        self.image = carro.imagem
        self.quantidade = carro.quantidade
        self.shopQuant = carro.shopQuant ?? 0
        self.favorite = false
    }
}
