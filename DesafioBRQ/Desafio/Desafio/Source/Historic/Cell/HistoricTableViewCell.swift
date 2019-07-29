//
//  HistoricTableViewCell.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 23/07/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit
import Kingfisher

class HistoricTableViewCell: UITableViewCell {

    
    @IBOutlet weak var uiImage: UIImageView!
    @IBOutlet weak var lbNomeCompra: UILabel!
    @IBOutlet weak var lbUnidades: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var View: UIView!
    
    var carrinho: Carrinho?
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
    
    func formatCell(_ compras: Carrinho) {
        if let urlImage = URL(string: compras.list.first?.imagem ?? "") {
            self.uiImage.kf.indicatorType = .activity
            self.uiImage.kf.setImage(with: urlImage)
        }
    }
//        guard let comp = compras else { return }
//        View.layer.cornerRadius = 10
//        for i in 0..<compras.list.count{
//
//        }
//        if let url = URL(string: comp.list[0].imagem) {
//            uiImage.kf.indicatorType = .activity
//            uiImage.kf.setImage(with: url)
//            if uiImage.image == nil {
//                uiImage.image = UIImage(named: "PUG")
//            }
//        }
//        lbNomeCompra.text = "Compra"
//        lbUnidades.text = "0"
//        lbTotal.text = "total"
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
