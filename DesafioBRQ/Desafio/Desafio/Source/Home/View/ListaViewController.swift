//
//  ListaViewController.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 10/04/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import Foundation
import CoreData


class ListaViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    var idCar = 0
    var indexPath: IndexPath?
    private var car = Carro()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isHidden = true
        showTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailsViewController
        vc.id = self.idCar
        vc.indexPath = self.indexPath
    }

    func showTableView() {
        DesafioAPI.loadcarros(onComplete: { [weak self] (cars) in
            Shop.shared.serviceRequest = cars
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.tableView.isHidden = false
            }
        }) { (error) in
            self.tableView.isHidden = true
            self.indicator.isHidden = false
            print(error)
        }
    }
    
    func alerta(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default ))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ListaViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Shop.shared.serviceRequest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let iten = Shop.shared.serviceRequest[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! ListaTableViewCell
        cell.delegate = self
        cell.carro = iten
        cell.id = iten.id
        cell.favorite = cell.validateFavorite()
        cell.indexPath = indexPath
        cell.formatCell(iten)
        return cell
    }
}

extension ListaViewController: ListaDelagate{
    func index(_ index: Int, indexPath: IndexPath) {
        self.idCar = index
        self.indexPath = indexPath
    }
    
    func tableviewReload() {
        self.tableView.reloadData()
    }
}
