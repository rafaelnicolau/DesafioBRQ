//
//  CarroHomePresenter.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 17/06/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import Foundation

protocol HomeCarroDelegate: NSObjectProtocol {
    func getCar(_ listViewData: CarroListViewData)
//    func setCarData()
}

//MARK CARROVIEWDATA
struct CarroListViewData {
    var totalCarros = 0
    var listCarros = [CarroViewData]()
}

struct CarroViewData {
    
    var id = 0
    var nome = ""
    var descricao = ""
    var marca = ""
    var quantidade = 0
    var preco = 0.0
    var imagem =  ""
}


class CarroHomePresenter {
   
    private var service = DesafioAPI()
    private weak var delegate: HomeCarroDelegate?
    private var viewData = [CarroViewData]()
    var cars: [Carro] = []
    
    init(viewDelegate: HomeCarroDelegate){
        self.delegate = viewDelegate
        self.service = DesafioAPI()
    }
    
    
    
     func cosumerService() {
        service.loadCarros { (data) in
            if let carros = data{
                self.cars += carros
                self.viewData = self.parseModelToViewData(self.cars)
            }
        }
    }
}



extension CarroHomePresenter {
    private func parseModelToViewData(_ carro: [Carro]) -> [CarroViewData]{
        var carroViewData = CarroViewData()
        for car in carro{
            carroViewData.descricao = car.descricao ?? ""
            carroViewData.id = car.id ?? 0
            carroViewData.imagem = car.imagem ?? ""
            carroViewData.marca = car.marca ?? ""
            carroViewData.nome = car.nome ?? ""
            carroViewData.preco = car.preco ?? 0.0
            carroViewData.quantidade = car.quantidade ?? 0
        }
        return [carroViewData]
    }
}


