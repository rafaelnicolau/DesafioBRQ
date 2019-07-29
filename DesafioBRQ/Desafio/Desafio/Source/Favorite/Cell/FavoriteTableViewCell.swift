//
//  FavoriteTableViewCell.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 24/07/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit
import Kingfisher

class FavoriteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var lbDesc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func formatCell(_ car: Carro) {
        self.view.layer.cornerRadius = 10
        if let url = URL(string: car.imagem ?? "") {
            ivImage.kf.indicatorType = .activity
            ivImage.kf.setImage(with: url)
            if ivImage.image == nil {
                ivImage.image = UIImage(named: "PUG")
            }
        }
        self.lbNome.text = car.nome
        self.lbDesc.text = car.descricao
    }

}
