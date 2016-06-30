//
//  ProductCell.swift
//  VelleMan_App
//
//  Created by Jarvics Soft on 12/03/1938 Saka.
//  Copyright © 1938 Saka Jarvics. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var noLbl3: UILabel!
    @IBOutlet weak var noLbl2: UILabel!
    @IBOutlet weak var NumberLbl1: UILabel!
    @IBOutlet weak var cutPriceLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var vegImage: UIImageView!
    @IBOutlet weak var vegName: UILabel!
    @IBOutlet weak var categoryDetail: UILabel!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
