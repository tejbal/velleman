//
//  currentOrderCell.swift
//  VelleMan_App
//
//  Created by Dimpal Singh on 07/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class currentOrderCell: UITableViewCell {

    @IBOutlet weak var cancelOrderLabel: UILabel!
    @IBOutlet weak var cancelOrder: UIButton!
    @IBOutlet weak var productInvoice: UILabel!
    @IBOutlet weak var paidStatus: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var orderName: UILabel!
    @IBOutlet weak var currentOrderImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
      cancelOrderLabel.textColor = ColorTheme().theme()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
