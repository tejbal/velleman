//
//  VegetablesViewCell.swift
//  VelleMan_App
//
//  Created by Dimpal Singh on 14/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class VegetablesViewCell: UITableViewCell {

    @IBOutlet weak var incrementBtn: UIButton!
    @IBOutlet weak var qtyTextField: UITextField!
    @IBOutlet weak var addtoCartButton: UIButton!
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var newPrice: UILabel!
    @IBOutlet weak var previousPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var no114: UILabel!
    @IBOutlet weak var no113: UILabel!
    @IBOutlet weak var no112: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addtoCartButton.titleLabel?.textColor = ColorTheme().theme()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
