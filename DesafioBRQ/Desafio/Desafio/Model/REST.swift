//
//  REST.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 22/03/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import Foundation
import Alamofire


class DesafioAPI {

    private let basePath = "https://desafiobrq.herokuapp.com/v1/carro/"
   
    
    func loadCarros(onComplete: @escaping ([Carro]?) -> Void) {
       let url = basePath
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data,
                let carros = try? JSONDecoder().decode([Carro].self, from: data),
                !carros.isEmpty else {
                    onComplete(nil)
                    return
            }
            onComplete(carros)
        }
    }
    
    func loadCarro(idCar: Int, onComplete: @escaping (Carro?) -> Void){
        if idCar == 0 {
            return
        } else {
        let url = basePath + "\(idCar)"

        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data else {return}
            do {
                let carro = try JSONDecoder().decode(Carro.self, from: data)
                onComplete(carro)
            } catch {
                print(error.localizedDescription)
                onComplete(nil)
            }
    
            }
        }
    }
}


