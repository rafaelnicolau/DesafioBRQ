//
//  SalesTableViewController.swift
//  Desafio
//
//  Created by Rafael Nicolau on 02/02/2019.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//
import Alamofire
import UIKit
import Kingfisher
import Foundation

class SalesTableViewController: UITableViewController {
    
    var carros: [Carro] = []
    var service = DesafioAPI()
    var isLoading = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Carros"
        }

  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        
        service.loadCarros { (cars) in
            self.isLoading = true
            if let cars = cars {
                self.carros = cars
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                    self.isLoading = false
                    self.tableView.reloadData()
                })
                
                }
        }
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! InfoViewController
        let idcar = carros[tableView.indexPathForSelectedRow!.row].id
        vc.id = idcar
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLoading ? 10 : carros.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellLoading", for: indexPath) as! LoadingTableViewCell
            cell.indicator.color = indexPath.row == 3 ? .red : .white
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CarTableViewCell
            cell.prepare(with: carros[indexPath.row])
            return cell
        }
        
    }
}

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

