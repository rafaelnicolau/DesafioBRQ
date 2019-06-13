//
//  CarsTableViewCell.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 10/04/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit
import Kingfisher
import Foundation

protocol CarDelegate {
    func buscarId(idCar: Int)
}

class CarsTableViewCell: UITableViewCell {
    
    var x: Int?
    var car: Carro?
    var indexOfRow = 0
    var delegate : CarDelegate?
    var iten: BdCarro!
    
    
    @IBOutlet weak var lbMarca: UILabel!
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var lbQuant: UILabel!
    @IBOutlet weak var lbPreco: UILabel!
    @IBOutlet weak var btDetails: UIButton!
    @IBOutlet weak var btComprar: UIButton!
    @IBOutlet weak var ivCarro: UIImageView!
    @IBOutlet weak var viewBackGround: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
   func prepare(with cars: Carro){
    car = cars
    viewBackGround.layer.cornerRadius = 15
    btDetails.layer.cornerRadius = 5
    btComprar.layer.cornerRadius = 5
    let preco = cars.preco as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale.current
        formatter.string(from: preco)
        formatter.locale = Locale(identifier: "pt-BR")
    lbPreco.text = formatter.string(from: preco)
    lbMarca.text = cars.marca
    lbNome.text = cars.nome
    lbQuant.text = "Unidade: \(cars.quantidade)"
    if let url = URL(string: cars.imagem) {
        ivCarro.kf.indicatorType = .activity
        ivCarro.kf.setImage(with: url)
        if ivCarro.image == nil {
            ivCarro.image = UIImage(named: "Fusca_icon")
        }
    }
}
 
    
    @IBAction func btDetails(_ sender: UIButton) {
        delegate?.buscarId(idCar: indexOfRow)
    }
    
    

    @IBAction func btComprar(_ sender: UIButton) {
       iten = BdCarro(context: context)
        
        iten.imagem = ivCarro.image
        iten.marca = lbMarca.text
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



    


