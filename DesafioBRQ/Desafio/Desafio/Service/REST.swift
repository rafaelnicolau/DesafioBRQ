//
//  REST.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 22/03/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import Foundation
import Alamofire

enum CarError{
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

class DesafioAPI {

    private static let basePath = "https://desafiobrq.herokuapp.com/v1/carro/"
   
    private static let configuration: URLSessionConfiguration = {
       let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type":"application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    
    class func loadcarros(onComplete:@escaping ([Carro]) -> Void, onError:@escaping (CarError) -> Void) {
        guard let url = URL(string: basePath) else {
            onError(.url)
            return
        }
        let dataTask = session.dataTask(with: url) { (info: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                if response.statusCode == 200{
                    guard let data = info else {return}
                    do{
                    let cars = try JSONDecoder().decode([Carro].self, from: data)
                       onComplete(cars)
                    } catch{
                        print(error.localizedDescription)
                        onError(.invalidJSON)
                    }
                } else {
                    onError(.responseStatusCode(code: response.statusCode))
                }
            } else {
                onError(.taskError(error: error!))
            }
    }
        dataTask.resume()
}
    
   class func loadCarro(idCar: Int, onComplete: @escaping (Carro?) -> Void){
        if idCar == 0 {
            return
        } else {
            let url = DesafioAPI.basePath + "\(idCar)"

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


