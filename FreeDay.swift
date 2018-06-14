//
//  FreeDay.swift
//  TimeManager
//
//  Created by Богдан Олег on 29.05.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import Foundation
import RealmSwift

class RealmFreeDay: Object {
    dynamic var id: Int = 0
    dynamic var date: String = ""
    dynamic var type: Int = 0
    
    override static func primaryKey() -> String?{
        return "id"
    }
    
}

class FreeDay {
    var date: String = ""
    var type: Int = 0
}
