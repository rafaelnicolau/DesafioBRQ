//
//  ShoppCartViewController.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 17/04/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit
import CoreData

class ShoppCartViewController: UIViewController {

    var fetchedResultController: NSFetchedResultsController<BdCarro>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCarro()
    }
    
    func loadCarro(){
        let fetchRequest: NSFetchRequest<BdCarro> = BdCarro.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "nome", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context , sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        
        do {
           try fetchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
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

extension ShoppCartViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = fetchedResultController.fetchedObjects?.count ?? 0
        
        return count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_compra", for: indexPath) as! ShoppCartTableViewCell
        guard let cars = fetchedResultController.fetchedObjects else { return cell }
        cell.prepare(with: cars[indexPath.row])
        return cell
    }
    
    
}

extension ShoppCartViewController : NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            break
        default:
            break
        }
    }
}
