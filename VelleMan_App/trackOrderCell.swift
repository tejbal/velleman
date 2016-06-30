//
//  trackOrderCell.swift
//  VelleMan_App
//
//  Created by Dimpal Singh on 07/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class trackOrderCell: UITableViewCell {
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var orderName: UILabel!
    @IBOutlet weak var wrapperView: UIView!

    @IBOutlet weak var trackStatus: UILabel!
    @IBOutlet weak var orderInvoice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
