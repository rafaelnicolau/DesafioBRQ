//
//  HistoricTableViewCell.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 23/07/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit
import Foundation
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
    
    func formatDate(_ Date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "pt_BR")
        return dateFormatter.string(from: Date)
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
        self.View.layer.cornerRadius = 10
        guard let date = compras.date else { return }
        self.lbNomeCompra.text = formatDate(date)
        if let urlImage = URL(string: compras.list.first?.imagem ?? "") {
            self.uiImage.kf.indicatorType = .activity
            self.uiImage.kf.setImage(with: urlImage)
            if uiImage.image == nil {
                uiImage.image = UIImage(named: "PUG")
            }
        }
        self.lbUnidades.text = "Itens comprados: \(compras.itens)"
        self.lbTotal.text = formatValor(valor: compras.total)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
