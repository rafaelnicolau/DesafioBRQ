//
//  Shop.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 11/07/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import Foundation

class Shop {
    
    static var shared = Shop()
    
    private init() {}
    
    var serviceRequest: [Carro] = []
    var carrinho = Carrinho()
//    var listCompras: Compra?
    var limitCredit = 100000.0
    var shopCredit = 0.0
    var defaults = UserDefaults.standard
    var historicShop = Historic()
    var favorite = Favorite()
    
    
    func addCarrinho(_ car: Carro, indexPath: IndexPath) {
        if carrinho.list.contains(where: {$0.id == car.id}) {
            for i in 0..<carrinho.list.count {
            if carrinho.list[i].id == car.id {
                carrinho.list[i].shopQuant? += 1
                serviceRequest[indexPath.row].quantidade -= 1
                carrinho.total += car.preco
                print(carrinho.total)
                break
            }
        }
        }else {
            carrinho.list.append(car)
            carrinho.date = Date()
            serviceRequest[indexPath.row].quantidade -= 1
            carrinho.itens = carrinho.list.count
            carrinho.total += car.preco
            for i in 0..<carrinho.list.count{
                if carrinho.list[i].id == car.id{
                    carrinho.list[i].shopQuant = 1
                    print(carrinho.total)
                    break
                }
            }
        }
    }
}
