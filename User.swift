//
//  User.swift
//  TimeManager
//
//  Created by Богдан Олег on 10.05.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUserName: Object {
    dynamic var id: Int = 0
    dynamic var fam: String = ""
    dynamic var name: String = ""
    dynamic var otch: String = ""
    dynamic var email :String = ""
    dynamic var password :String = ""
    
    override static func primaryKey() -> String?{
        return "id"
    }
}


class UserName {
    var id :Int = 0
    var login :String = ""
    var password :String = ""
    init() {
        self.id = 0
        self.login = ""
        self.password = ""
        
    }
    init(login: String, password: String, id: Int) {
        self.login = login
        self.password = password
        self.id = id
    }
}

class CurUser: Object {
    dynamic var id: Int = 0
    dynamic var login: String = ""
    dynamic var password: String = ""
    
    override static func primaryKey() -> String?{
        return "id"
    }
}
