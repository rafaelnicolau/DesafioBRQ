//
//  ShopCellTableViewCell.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 11/07/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit
import Kingfisher

protocol ShopCellDelegate: NSObjectProtocol {
    func tableviewReload()
}


class ShopCellTableViewCell: UITableViewCell {

    @IBOutlet weak var ShopView: UIView!
    @IBOutlet weak var ImageCar: UIImageView!
    @IBOutlet weak var lbMarca: UILabel!
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var lbQuant: UILabel!
    
    var car: Carro?
    var delegate: ShopCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func formatCell(_ carro: Carro){
        ShopView.layer.cornerRadius = 10
        if let url = URL(string: carro.imagem) {
            ImageCar.kf.indicatorType = .activity
            ImageCar.kf.setImage(with: url)
            if ImageCar.image == nil {
                ImageCar.image = UIImage(named: "PUG")
            }
        }
        guard let quant = carro.shopQuant else { return }
        lbQuant.text = String("Quantidade: \(quant)")
        lbMarca.text = carro.marca
        lbNome.text = carro.nome
    }
}
