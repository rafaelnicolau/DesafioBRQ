//
//  ListaTableViewCell.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 20/06/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit
import Kingfisher

protocol ListaDelagate: NSObjectProtocol {
    func index(_ index: Int, indexPath: IndexPath)
    func tableviewReload()
}

class ListaTableViewCell: UITableViewCell {

   
    @IBOutlet weak var ViewCell: UIView!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lbMarca: UILabel!
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var lbUnidade: UILabel!
    @IBOutlet weak var lbPreco: UILabel!
    @IBOutlet weak var btComprar: UIButton!
    @IBOutlet weak var btDetail: UIButton!
    @IBOutlet weak var btFavorite: UIButton!
    
     var carro: Carro?
     var delegate: ListaDelagate?
     var id = 0
     var indexPath: IndexPath?
     var favorite = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.validadeBtComprar()
        self.favorite = false
        self.btFavorite.setImage(UIImage(named: "favoriteIsEmpty"), for: .normal)
    }
    
    func validadeBtComprar() {
        guard let index = indexPath else { return }
        if Shop.shared.serviceRequest[index.row].quantidade >= 1 {
            self.btComprar.isEnabled = true
        }else {
            self.btComprar.isEnabled = false
        }
    }
    
    func validateFavorite() -> Bool{
        if Shop.shared.favorite.listFavorite.contains(where: { ($0.id == id)}) {
            return true
        }
        return false
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
    
    func formatCell(_ carro: Carro) {
        ViewCell.layer.cornerRadius = 10
        btDetail.layer.cornerRadius = 10
        btComprar.layer.cornerRadius = 10
        if !favorite {
            self.btFavorite.setImage(UIImage(named: "favoriteIsEmpty"), for: .normal)
        }else{
            self.btFavorite.setImage(UIImage(named: "favoriteFull"), for: .normal)
        }
        if let url = URL(string: carro.imagem ?? "") {
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
        lbNome.text = carro.nome
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func setFavorite() {
        guard let index = indexPath else { return }
        let car = Shop.shared.serviceRequest[index.row]
        if !favorite {
            self.btFavorite.setImage(UIImage(named: "favoriteFull"), for: .normal)
            Shop.shared.favorite.listFavorite.append(car)
            self.favorite = true

        }else{
            self.btFavorite.setImage(UIImage(named: "favoriteIsEmpty"), for: .normal)
            findFavoriteAndRemove(car)
            self.favorite = false
        }
    }
    
    func findFavoriteAndRemove(_ car: Carro){
        Shop.shared.favorite.listFavorite = Shop.shared.favorite.listFavorite.filter(){($0.id != car.id)}
    }
    
    
    
    
    @IBAction func btFavorite(_ sender: Any) {
        setFavorite()
    }
    
    @IBAction func btDetail(_ sender: Any) {
        guard let index = indexPath else { return }
        delegate?.index(id, indexPath: index)
    }
        
    @IBAction func btComprar(_ sender: Any) {
        if let car = self.carro, let index = self.indexPath{
            Shop.shared.addCarrinho(car, indexPath: index)
            delegate?.tableviewReload()
            self.btComprarStop(car)
        }
    }

    
    func btComprarStop(_ car: Carro){
        for i in 0..<Shop.shared.serviceRequest.count{
            if Shop.shared.serviceRequest[i].id == car.id{
                if Shop.shared.serviceRequest[i].quantidade >= 1{
                    btComprar.backgroundColor = UIColor(named: "main")
                    btComprar.isEnabled = true
                }else {
                    btComprar.backgroundColor = .gray
                    btComprar.isEnabled = false
                }
            }
        }
    }
}

