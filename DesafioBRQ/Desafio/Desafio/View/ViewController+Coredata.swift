//
//  ViewController+Coredata.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 22/04/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit
import CoreData

extension UITableViewCell {
    
    var context: NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.viewContext
    }
}

extension UIViewController {
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}

