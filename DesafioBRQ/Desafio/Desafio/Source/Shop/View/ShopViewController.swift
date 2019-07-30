//
//  ShopViewController.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 11/07/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {

    
    @IBOutlet weak var ShopTableView: UITableView!
    @IBOutlet weak var btEnd: UIButton!
    @IBOutlet weak var lbShopEmpty: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btEnd.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showTableView()
    }
    
    func showTableView(){
        if Shop.shared.carrinho.list.isEmpty || Shop.shared.carrinho.list.count == 0  {
            ShopTableView.isHidden = true
            btEnd.isEnabled = false
            btEnd.alpha = 0.5
            lbShopEmpty.isHidden = false
            lbShopEmpty.text = "Lista de Compras vazia..."
            self.ShopTableView.reloadData()
        }else {
            ShopTableView.isHidden = false
            btEnd.isEnabled = true
            lbShopEmpty.isHidden = true
            btEnd.alpha = 1
            ShopTableView.backgroundColor = .clear
            self.ShopTableView.reloadData()
        }
    }
    
    func findIdServiceRequest(_ car: Carro){
        guard let quantCar = car.shopQuant else { return }
        for i in 0..<Shop.shared.serviceRequest.count {
            if Shop.shared.serviceRequest[i].id == car.id {
                Shop.shared.serviceRequest[i].quantidade += quantCar
            }
        }
    }
    func findIdServiceRequestForOne(_ car: Carro){
        for i in 0..<Shop.shared.serviceRequest.count {
            if Shop.shared.serviceRequest[i].id == car.id {
                Shop.shared.serviceRequest[i].quantidade += 1
            }
        }
    }
    
    func findIdServiceRequestForDeleteOne(_ car: Carro){
        for i in 0..<Shop.shared.serviceRequest.count {
            if Shop.shared.serviceRequest[i].id == car.id {
                Shop.shared.serviceRequest[i].quantidade -= 1
            }
        }
    }
    
    @IBAction func btEnd(_ sender: Any) {
        endShop()
    }
    
    func alerta(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
 
    func endShop() {
        if Shop.shared.carrinho.total > 100000.0 {
            alerta(title: "Atenção", message: "Limite de compra é de R$ 100.000")
        }else {
            Shop.shared.historicShop.date = Shop.shared.carrinho.date
            Shop.shared.historicShop.listCompra.append(Shop.shared.carrinho)
            Shop.shared.carrinho.date = Date()
            Shop.shared.carrinho = Carrinho()
            alerta(title: "Atenção", message: "Compras Finalizadas")
            showTableView()
        }
    }
}
    


extension ShopViewController: UITableViewDelegate , UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Shop.shared.carrinho.list.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCell") as! ShopCellTableViewCell
        cell.formatCell(Shop.shared.carrinho.list[indexPath.row])
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let car = Shop.shared.carrinho.list[indexPath.row]

        let deleteAll = UIContextualAction(style: .normal, title: "") { (action, view, completionHandler) in
            completionHandler(true)
            self.deleteAction(carro: car, indexpath: indexPath)
        }
        deleteAll.image = UIImage(named: "lixeira")
        deleteAll.backgroundColor = UIColor.init(named: "main")

        let deleteOne = UIContextualAction(style: .normal, title: "") { (action, view, completionHandler) in
            completionHandler(true)
            self.deleteOneAction(carro: car, indexpath: indexPath)
        }
        deleteOne.image = UIImage(named: "menos")
        deleteOne.backgroundColor = UIColor.init(named: "main")

        let addOne = UIContextualAction(style: .normal, title: "") { (action, view, completionHandler) in
            completionHandler(true)
            self.addOneCar(carro: car, indexpath: indexPath)
        }
        addOne.image = UIImage(named: "mais")
        addOne.backgroundColor = UIColor.init(named: "main")

        let config = UISwipeActionsConfiguration(actions: [deleteAll, deleteOne, addOne])

        return config
    }

    func addOneCar(carro: Carro, indexpath: IndexPath){
        let alert = UIAlertController(title: "Adicionar", message: "Deseja adicionar um Carro?", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "SIM", style: .default) { (Action) in
            guard let quantCar = carro.shopQuant else { return }
            if quantCar >= 1 {
                self.findIdServiceRequestForDeleteOne(carro)
                carro.shopQuant = quantCar + 1
                Shop.shared.carrinho.total += carro.preco
                self.showTableView()
            }
            self.showTableView()
        }
        let cancelAction = UIAlertAction(title: "NÃO", style: .default, handler: nil)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        self.showTableView()
        present(alert, animated: true)
    }

    func deleteOneAction(carro: Carro, indexpath: IndexPath){
        let alert = UIAlertController(title: "Delete", message: "Deseja excluir um Carro?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "SIM", style: .default) { (Action) in
            guard let quantCar = carro.shopQuant else { return }
            if quantCar >= 2 {
                carro.shopQuant! -= 1
                self.findIdServiceRequestForOne(carro)
                Shop.shared.carrinho.total -= carro.preco
                self.showTableView()
            }else if carro.shopQuant! == 1 {
                Shop.shared.carrinho.list.remove(at: indexpath.row)
                self.findIdServiceRequestForOne(carro)
                Shop.shared.carrinho.total -= carro.preco
                self.showTableView()
            }
        }
        let cancelAction = UIAlertAction(title: "NÃO", style: .default, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.showTableView()
        present(alert, animated: true)
    }

    func deleteAction(carro: Carro, indexpath: IndexPath){
        if let quantCar = carro.shopQuant {
        let valor = carro.preco * Double(quantCar)
        Shop.shared.shopCredit -= Double(valor)
        findIdServiceRequest(carro)
        Shop.shared.carrinho.list.remove(at: indexpath.row)
        self.showTableView()
        }
//        let alert = UIAlertController(title: "Delete", message: "Deseja excluir o Carro?", preferredStyle: .alert)
//        let deleteAction = UIAlertAction(title: "SIM", style: .default) { (Action) in
            if let quantCar = carro.shopQuant {
                let valor = carro.preco * Double(quantCar)
                Shop.shared.carrinho.total -= Double(valor)
            }
//            Shop.shared.carrinho.list.removeAll()
        for i in 0..<Shop.shared.carrinho.list.count{
            if Shop.shared.carrinho.list[i].id == carro.id {
                Shop.shared.carrinho.list.remove(at: i)
                Shop.shared.carrinho.total -= carro.preco
            }
        }
            self.showTableView()
        }
//        let cancelAction = UIAlertAction(title: "NÃO", style: .default, handler: nil)
//        alert.addAction(deleteAction)
//        alert.addAction(cancelAction)
//        self.showTableView()
//        present(alert, animated: true)
}

extension ShopViewController: ShopCellDelegate {
    func tableviewReload() {
        self.ShopTableView.reloadData()
    }
    
    
}

