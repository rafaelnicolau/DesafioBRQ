//
//  SalesTableViewCell.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 27/03/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit

class SalesTableViewCell: UITableViewCell {

    
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
        lbMarca.text = cars.marca
        lbNome.text = cars.nome
        lbQuant.text = String(cars.quantidade)
        lbPreco.text = String(cars.preco)
    }
    
    
}
