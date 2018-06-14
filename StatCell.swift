//
//  StatCell.swift
//  TimeManager
//
//  Created by Богдан Олег on 14.05.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit

class StatCell: UITableViewCell {

    @IBOutlet weak var textDate: UILabel!
    @IBOutlet weak var textIn: UILabel!
    @IBOutlet weak var textTime: UILabel!
    @IBOutlet weak var textOut: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
