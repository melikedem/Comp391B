//
//  FruitsTableViewCell.swift
//  FruitsAndVeggies
//
//  Created by Apple on 2.11.2019.
//  Copyright © 2019 Melike. All rights reserved.
//

import UIKit

class FruitsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fruitImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
