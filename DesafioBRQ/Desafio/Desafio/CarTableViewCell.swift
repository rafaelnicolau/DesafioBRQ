//
//  CarTableViewCell.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 27/03/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit
import Kingfisher
import Foundation

class CarTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ivCarro: UIImageView!
    @IBOutlet weak var lbMarca: UILabel!
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var lbQuant: UILabel!
    @IBOutlet weak var lbPreco: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with cars: Carros){
       let preco = cars.preco as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale.current
        formatter.string(from: preco)
        formatter.locale = Locale(identifier: "pt-BR")
        var id = cars.id
        var descri = cars.descricao
        lbMarca.text = cars.marca
        lbNome.text = cars.nome
        lbQuant.text = String(cars.quantidade)
        lbPreco.text = formatter.string(from: preco)
        if let url = URL(string: cars.imagem) {
            ivCarro.kf.indicatorType = .activity
            ivCarro.kf.setImage(with: url)
            if ivCarro.image == nil {
                ivCarro.image = UIImage(named: "Fusca_icon")
            }
        } else {
            ivCarro.image = UIImage(named: "Fusca_icon")
        }
            
        func prepareForSegue(for segue: UIStoryboardSegue, sender: AnyObject?) {
            let infoViewController = segue.destination as! InfoViewController
            infoViewController.ivCarro = ivCarro
            infoViewController.lbNome = lbNome
            infoViewController.lbPreco = lbPreco
        }
        
    }
    
  
}
