//
//  LoadingTableViewCell.swift
//  Desafio
//
//  Created by Rafael Ignacio da Silva Nicolau on 04/04/19.
//  Copyright © 2019 Rafael Nicolau. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
