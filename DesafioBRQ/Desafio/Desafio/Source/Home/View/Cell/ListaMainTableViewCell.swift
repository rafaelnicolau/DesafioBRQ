//
//  ListaMainTableViewCell.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 16/08/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit

class ListaMainTableViewCell: UITableViewCell {

    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lbMarca: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPreco: UILabel!
    @IBOutlet weak var lbUnidade: UILabel!
    @IBOutlet weak var btFavorite: UIButton!
    @IBOutlet weak var btDetail: UIButton!
    @IBOutlet weak var btComprar: UIButton!
    
    var carViewData: CarViewData?
    var delegate: ListaMainDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    
    func formatCell(_ carro: CarViewData) {
        backGroundView.layer.cornerRadius = 10
        btDetail.layer.cornerRadius = 10
        btComprar.layer.cornerRadius = 10
        if !carro.favorite {
            self.btFavorite.setImage(UIImage(named: "favoriteIsEmpty"), for: .normal)
        }else{
            self.btFavorite.setImage(UIImage(named: "favoriteFull"), for: .normal)
        }
        if let url = URL(string: carro.image) {
            ivImage.kf.indicatorType = .activity
            ivImage.kf.setImage(with: url)
            if ivImage.image == nil {
                ivImage.image = UIImage(named: "PUG")
            }
        }
        lbPreco.text = formatValor(valor: carro.preco)
        lbUnidade.text = "\(String(describing: carro.quantidade))Un."
        lbUnidade.alpha = 0.5
        lbMarca.text = carro.marca
        lbName.text = carro.nome
    }
    
}
