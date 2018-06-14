//
//  Message.swift
//  TimeManager
//
//  Created by Богдан Олег on 10.05.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import Foundation
import UIKit

class ShowMessage {
    class func print(stitle:String,smessage:String,buttontext:String) -> UIAlertController {
        let message = UIAlertController(title: stitle, message: smessage, preferredStyle: .alert)
        message.addAction(UIAlertAction(title: buttontext, style: .default, handler: nil))
        return message
    }
}
