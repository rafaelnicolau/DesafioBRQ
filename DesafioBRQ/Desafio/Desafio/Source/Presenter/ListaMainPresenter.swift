//
//  ListaMainPresenter.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 16/08/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import Foundation

protocol ListaMainDelegate: NSObjectProtocol{
    func showTableView()
    func showLoading()
    func stopLoading()
    func emptyList()
    func gernicError()
    func setViewData(_ viewData: [CarViewData])
    func setCar(_ carro: CarViewData)
}

class ListaMainPresenter {
    
    private var carsViewData = [CarViewData]()
    weak private var listaMainDelegate: ListaMainDelegate?
    
    func setDelegate(listaMainDelegate: ListaMainDelegate){
        self.listaMainDelegate = listaMainDelegate
    }
    
    //MARK LOAD_SERVICE
    func loadCarros(){
    DesafioAPI.loadcarros(onComplete: { [weak self] (cars) in
    Shop.shared.serviceRequest = cars
        self?.carsViewData = Shop.shared.serviceRequest.map({ (carro) -> CarViewData in
            return CarViewData(carro: carro)
        })
    DispatchQueue.main.async {
        guard let cars = self?.carsViewData else { return }
        self?.listaMainDelegate?.setViewData(cars)
        self?.listaMainDelegate?.showTableView()
    }
    }) { (error) in
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
        self.listaMainDelegate?.gernicError()
        })
    }
}
    
}
