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
    private let listaMainPresenter = ListaMainPresenter()
    private var carsViewData: [CarViewData]?

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ListaMainTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ListaMainTableViewCellXIB")
        self.listaMainPresenter.setDelegate(listaMainDelegate: self)
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
    
    func alerta(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default ))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ListaViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let carsViewData = self.carsViewData else {return 0}
        return carsViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let carsViewData = self.carsViewData else { return UITableViewCell() }
        let iten = carsViewData[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! ListaMainTableViewCell
        cell.delegate = self
        cell.carViewData = iten
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

extension ListaViewController: ListaMainDelegate{
    func showTableView() {
        //
    }
    
    func showLoading() {
        //
    }
    
    func stopLoading() {
        //
    }
    
    func emptyList() {
        //
    }
    
    func gernicError() {
        //
    }
    
    func setViewData(_ viewData: [CarViewData]) {
        self.carsViewData = viewData
    }
    
    func setCar(_ carro: CarViewData) {
        //
    }
    
    
}
