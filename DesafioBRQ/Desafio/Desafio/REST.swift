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

    func loadCarros(onComplete: @escaping ([Carros]?) -> Void) {
       let url = basePath
        Alamofire.request(url).responseJSON { (response) in
            guard let data = response.data,
                let carros = try? JSONDecoder().decode([Carros].self, from: data),
                !carros.isEmpty else {
                    onComplete(nil)
                    return
            }
            onComplete(carros)
        }
    }
}

