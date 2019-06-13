//
//  ShoppCart.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 17/04/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import Foundation


class ShoppCart {
    var cesta: [Carro] = []
    
    func addProduto(carro: Carro){
        cesta.append(carro)
    }
    
    func imprimir() {
        for i in 0...cesta.count - 1 {
            print(cesta[i].toString())
        }
    }
}
