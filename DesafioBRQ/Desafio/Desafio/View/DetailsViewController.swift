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

    var id: Int = 0
    var carro: Carro?
    var service = DesafioAPI()
    var iten: BdCarro!
  
    
    @IBOutlet weak var ivCarro: UIImageView!
    @IBOutlet weak var lbPreco: UILabel!
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var lbDetails: UILabel!
    @IBOutlet weak var Indicator: UIActivityIndicatorView!
    @IBOutlet weak var btAddCarrinho: UIButton!
    @IBOutlet weak var lbQuant: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btAddCarrinho.isHidden = true
        service.loadCarro(idCar: id) { (car) in
            if let car = car {
                self.carro = car
                self.loadDetails()
            }
        // Do any additional setup after loading the view.
    }
}

        func loadDetails(){
            Indicator.isHidden = true
            btAddCarrinho.isHidden = false
            btAddCarrinho.layer.cornerRadius = 10
            title = carro?.marca
            lbDetails.text = carro?.descricao
            lbQuant.text = "Unidades: \(carro!.quantidade)"
            let preco = carro!.preco as NSNumber
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = NSLocale.current
            formatter.string(from: preco)
            formatter.locale = Locale(identifier: "pt-BR")
            lbPreco.text = formatter.string(from: preco)
            lbNome.text = carro?.nome
            if let url = URL(string: (carro!.imagem)) {
                ivCarro.kf.indicatorType = .activity
                ivCarro.kf.setImage(with: url)
                if ivCarro.image == nil {
                    ivCarro.image = UIImage(named: "Fusca_icon")
                }
            }
        }
    
    @IBAction func btComprar(_ sender: UIButton) {
        iten = BdCarro(context: context)
        
        iten.imagem = ivCarro.image
        iten.marca = title
        iten.nome = lbNome.text
        iten.preco = lbPreco.text
        iten.quantidade = lbQuant.text
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}




