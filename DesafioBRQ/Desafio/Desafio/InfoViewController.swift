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

    var carros: Carros!
    
    @IBOutlet weak var ivCarro: UIImageView!
    @IBOutlet weak var lbPreco: UILabel!
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var lbDescri: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        func prepare(with cars: Carros){
            let preco = cars.preco as NSNumber
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = NSLocale.current
            formatter.string(from: preco)
            formatter.locale = Locale(identifier: "pt-BR")
            
            if let url = URL(string: cars.imagem) {
                ivCarro.kf.indicatorType = .activity
                ivCarro.kf.setImage(with: url)
                if ivCarro.image == nil {
                    ivCarro.image = UIImage(named: "Fusca_icon")
                }
            } else {
                ivCarro.image = UIImage(named: "Fusca_icon")
            }
            lbNome.text = cars.nome
            lbDescri.text = cars.descricao
        }
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
