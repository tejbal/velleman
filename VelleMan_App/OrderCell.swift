//
//  OrderCell.swift
//  VelleMan_App
//
//  Created by Dimpal Singh on 06/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var previousPriceLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var noLbl3: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var noLbl2: UILabel!
    @IBOutlet weak var noLbl1: UILabel!
    @IBOutlet weak var orderProductName: UILabel!
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var boxQuantityLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
