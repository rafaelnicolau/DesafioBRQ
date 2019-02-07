//
//  ViewController.swift
//  Desafio
//
//  Created by Rafael Nicolau on 31/01/2019.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btVendas(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

