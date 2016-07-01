//
//  OrderHistoryCell.swift
//  VelleMan_App
//
//  Created by Jarvics Soft on 12/03/1938 Saka.
//  Copyright © 1938 Saka Jarvics. All rights reserved.
//

import UIKit

class OrderHistoryCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var paidStatus: UILabel!
    @IBOutlet weak var trackImage: UIImageView!
    @IBOutlet weak var invoiceName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
