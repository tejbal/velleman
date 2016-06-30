//
//  addressListCell.swift
//  VelleMan_App
//
//  Created by Dimpal Singh on 06/06/16.
//  Copyright © 2016 Jarvics. All rights reserved.
//

import UIKit

class addressListCell: UITableViewCell {

    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var checkButton: UIImageView!
    @IBOutlet weak var addressDetail: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
