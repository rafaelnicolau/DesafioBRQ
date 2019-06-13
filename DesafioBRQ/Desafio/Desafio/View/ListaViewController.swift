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

class ListaViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var Indicator: UIActivityIndicatorView!
    
    var carros: [Carro] = []
    var service = DesafioAPI()
    var index = 0
    private let refresh = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Carros"
        self.tableview.isHidden = true
        self.showTableView()
        service.loadCarros { (cars) in
            if let cars = cars{
                self.carros = cars
                self.tableview.reloadData()
            }
        }
    }
    func showTableView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 8 ) {
            self.tableview.isHidden = false
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func addCart(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "cell_shop", sender: nil)
    }
    
    
}



extension ListaViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(carros.count)
        return carros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CarsTableViewCell
        cell.delegate = self
        cell.indexOfRow = carros[indexPath.row].id
        cell.prepare(with: carros[indexPath.row])
        return cell
    }
    
    
}

extension ListaViewController : UITableViewDelegate {
    
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

extension ListaViewController: CarDelegate {
    func buscarId(idCar: Int) {
        self.index = idCar
        performSegue(withIdentifier: "segueDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? DetailsViewController, segue.identifier == "segueDetails" {
            viewController.id = self.index
        }
    }
}


