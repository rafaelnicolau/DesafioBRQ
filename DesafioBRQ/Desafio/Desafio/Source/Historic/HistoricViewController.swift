//
//  HistoricViewController.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 23/07/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit

class HistoricViewController: UIViewController {

    
    @IBOutlet weak var lbMsgInicial: UILabel!
    @IBOutlet weak var tbHistoric: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTableView()
        

    }
    override func viewWillAppear(_ animated: Bool) {
        showTableView()
    }
   
    func showTableView(){
        if Shop.shared.historicShop.listCompra.isEmpty || Shop.shared.historicShop.listCompra.count == 0 {
            self.tbHistoric.isHidden = true
            self.lbMsgInicial.isHidden = false
            self.lbMsgInicial.text = "Ainda não tem nenhum Histórico..."
        }else {
            self.tbHistoric.isHidden = false
            self.lbMsgInicial.isHidden = true
            self.tbHistoric.reloadData()
        }
    }
    
}



extension HistoricViewController: UITableViewDataSource, UITabBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Shop.shared.historicShop.listCompra.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let iten = Shop.shared.historicShop.listCompra[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellHistoric") as! HistoricTableViewCell
        cell.formatCell(iten)
        return cell
    }
    
    
}
