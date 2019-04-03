//
//  InfoViewController.swift
//  Desafio
//
//  Created by Rafael Nicolau on 02/02/2019.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit
import Kingfisher

class InfoViewController: UIViewController {

    var id: Int = 0
    var carro: Carro?
    var carrinho: [Carro] = []
    static var totalcarrinho: [Carro] = []
    var service = DesafioAPI()
    
    @IBOutlet weak var ivCarro: UIImageView!
    @IBOutlet weak var lbPreco: UILabel!
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var lbDescri: UILabel!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        service.loadCarro(idCar: id) { (car) in
            if let car = car {
                self.carro = car
                self.loadInfos()
                }
            }
        
       
        }


    func loadInfos(){
        title = carro!.nome
        let preco = carro!.preco as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale.current
        formatter.string(from: preco)
        formatter.locale = Locale(identifier: "pt-BR")
        lbNome.text = carro?.nome
        lbPreco.text = formatter.string(from: preco)
        lbDescri.text = carro?.descricao
        if let url = URL(string: (carro?.imagem)!) {
            ivCarro.kf.indicatorType = .activity
            ivCarro.kf.setImage(with: url)
            if ivCarro.image == nil {
                ivCarro.image = UIImage(named: "Fusca_icon")
            }
        } else {
            ivCarro.image = UIImage(named: "Fusca_icon")
        }
    }
    

    @IBAction func addCarrinho(_ sender: UIButton) {
        let alert = UIAlertController(title: "Você deseja comprar esse \(carro!.nome)?", message: "Ele está custando \(lbPreco.text!)", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))
        self.present(alert, animated: true)

        carrinho.insert(carro!, at: 0)
        print(carrinho)


}
}

