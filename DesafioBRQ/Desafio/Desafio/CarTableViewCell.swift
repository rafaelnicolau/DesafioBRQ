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

    var id: Int?
    var descri: String?
    var car: Carro?
    
    
    @IBOutlet weak var ivCarro: UIImageView!
    @IBOutlet weak var lbMarca: UILabel!
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var lbQuant: UILabel!
    @IBOutlet weak var lbPreco: UILabel!
    @IBAction func btteste(_ sender: UIButton) {
        let alert = UIAlertController(title: "Você deseja comprar esse?", message: "Ele está custando", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))
        
    }
    
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
        print(car!)
       let preco = cars.preco as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale.current
        formatter.string(from: preco)
        formatter.locale = Locale(identifier: "pt-BR")
        self.id = cars.id
        self.descri = cars.descricao
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
    }
    
    func prepareForSegue(for segue: UIStoryboardSegue, sender: AnyObject?) {
        id = car?.id
        let infoViewController = segue.destination as! InfoViewController
        infoViewController.id = self.id!
    }
    
  
}
