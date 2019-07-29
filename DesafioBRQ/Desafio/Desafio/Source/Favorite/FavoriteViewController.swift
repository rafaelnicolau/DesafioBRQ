//
//  FavoriteViewController.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 24/07/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    
    @IBOutlet weak var tbFavorite: UITableView!
    @IBOutlet weak var lbTextFavorite: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbFavorite.backgroundColor = .clear
        showTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showTableView()
       
    }

    func showTableView(){
        if Shop.shared.favorite.listFavorite.isEmpty || Shop.shared.favorite.listFavorite.count == 0 {
            self.tbFavorite.isHidden = true
            self.lbTextFavorite.isHidden = false
            self.lbTextFavorite.text = "Ainda não tem nenhum Favorito..."
            self.tbFavorite.reloadData()
        }else {
            self.tbFavorite.isHidden = false
            self.lbTextFavorite.isHidden = true
            self.tbFavorite.reloadData()
        }
    }

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Shop.shared.favorite.listFavorite.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFavorite") as! FavoriteTableViewCell
        cell.formatCell(Shop.shared.favorite.listFavorite[indexPath.row])
        return cell
    }
    
    
}
