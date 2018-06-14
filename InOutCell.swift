//
//  InOutCell.swift
//  TimeManager
//
//  Created by Богдан Олег on 11.05.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit

class InOutCell: UITableViewCell {

    @IBOutlet weak var timeIn: UILabel!
    @IBOutlet weak var timeOut: UILabel!
    @IBOutlet weak var timeWork: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
