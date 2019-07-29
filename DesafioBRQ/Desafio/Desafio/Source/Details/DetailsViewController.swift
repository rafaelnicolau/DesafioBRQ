//
//  DetailsViewController.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 11/04/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit
import Kingfisher
import Foundation

class DetailsViewController: UIViewController {
  
    
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lbMarca: UILabel!
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var lbDesc: UILabel!
    @IBOutlet weak var lbPreco: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var btComprar: UIButton!
    @IBOutlet weak var btBack: UIButton!
    @IBOutlet weak var lbReturnSerive: UILabel!
    @IBOutlet weak var backGroundImageView: UIView!
    @IBOutlet weak var lbUnidades: UILabel!
    
    var id = 0
    var car = Carro()
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backGroundImageView.isHidden = true
        btComprar.isHidden = true
        btBack.isHidden = true
        lbReturnSerive.isHidden = true
        showObject()
        }
    
    func showObject(){
        activityIndicator.isHidden = false
        DesafioAPI.loadCarro(idCar: id) { [weak self] (car) in
            if let obj = car {
                self?.car = obj
                self?.formatCar(obj)
                self?.activityIndicator.isHidden = true
            }else {
                self?.lbReturnSerive.isHidden = false
                self?.activityIndicator.isHidden = true 
                self?.lbReturnSerive.text = "Não foi possivel apresentar o Carro"
                self?.btBack.isHidden = false
            }
        }
    }
    
    func showObjectTwo(){
        activityIndicator.isHidden = true
        DesafioAPI.loadCarro(idCar: id) { [weak self] (car) in
            if let obj = car {
                self?.car = obj
                self?.formatCar(obj)
            }
        }
    }
    
 
    func formatValor(valor: Double) -> String{
        let Valor = valor as NSNumber
        let format = NumberFormatter()
        format.usesGroupingSeparator = true
        format.numberStyle = .currency
        format.locale = Locale.current
        format.locale = Locale.init(identifier: "pt-BR")
        return format.string(from: Valor)!
    }
    
    func formatCar(_ carro: Carro ){
        btComprar.layer.cornerRadius = 10
        backGroundImageView.isHidden = false
        ivImage.backgroundColor = .white
        if let url = URL(string: carro.imagem ){
            ivImage.kf.indicatorType = .activity
            ivImage.kf.setImage(with: url)
            if ivImage.image == nil {
                ivImage.image = UIImage(named: "PUG")
            }
        }
        lbPreco.text = formatValor(valor: carro.preco )
        lbDesc.text = carro.descricao
        lbMarca.text = carro.marca
        lbNome.text = carro.nome
        for i in 0...Shop.shared.serviceRequest.count - 1{
            if Shop.shared.serviceRequest[i].id == car.id {
                carro.quantidade = Shop.shared.serviceRequest[i].quantidade
            }
        }
        lbUnidades.text = "Un. \(carro.quantidade)"
        if carro.quantidade == 0 {
            btComprar.isHidden = true
        }else {
        btComprar.isHidden = false
        }
        btBack.isHidden = false
    }
        
    @IBAction func btBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btComprar(_ sender: Any) {
        Shop.shared.addCarrinho(car, indexPath: self.indexPath!)
        showObjectTwo()
        alerta(title: "Comprar Efetuada", message: "Compra Efetuada com Sucesso.")
    }
    
    func alerta(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default ))
        self.present(alert, animated: true, completion: nil)
    }
    
}
