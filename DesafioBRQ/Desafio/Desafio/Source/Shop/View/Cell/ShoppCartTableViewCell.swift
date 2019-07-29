//
//  ShoppCartTableViewCell.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 17/04/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit

class ShoppCartTableViewCell: UITableViewCell {

  
    @IBOutlet weak var ivCarro: UIImageView!
    @IBOutlet weak var lbMarca: UILabel!
    @IBOutlet weak var lbModelo: UILabel!
    @IBOutlet weak var lbQuant: UILabel!
    @IBOutlet weak var lbValor: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func prepare(with carro: BdCarro){
        lbMarca.text = carro.marca ?? ""
        lbModelo.text = carro.nome ?? ""
        lbValor.text = carro.preco ?? ""
        lbQuant.text = carro.quantidade ?? ""
        if let image = carro.imagem as? UIImage {
            ivCarro.image = image
        }else {
            ivCarro.image = UIImage(named: "Fusca_icon")
        }
        
    }
    
}
