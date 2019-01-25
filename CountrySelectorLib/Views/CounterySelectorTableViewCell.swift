//
//  CounterySelectorTableViewCell.swift
//  CountrySelector
//
//  Created by MoHamed Shaat on 1/24/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import UIKit

class CounterySelectorTableViewCell: UITableViewCell {

    @IBOutlet weak var counterFlag: UIImageView!
    @IBOutlet weak var counteryNameLabel: UILabel!
    @IBOutlet weak var counteryCodeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(countery: Country) {
        self.counterFlag.image = countery.counterFlag
        self.counteryNameLabel.text = countery.name
        self.counteryCodeLabel.text = countery.phoneCode
    }
}
