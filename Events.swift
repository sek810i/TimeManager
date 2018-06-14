//
//  Events.swift
//  TimeManager
//
//  Created by Богдан Олег on 22.01.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import Foundation
import RealmSwift

let ip = "http://sek810i-apps.ru/"

let realmUrl = URL(string: "realm://\(ip):9080/~/TimeManager")!
let authServerUrl = URL(string: "http://\(ip):9080/")!
let credecial = SyncCredentials.usernamePassword(username: "sek810i96@gmail.com", password: "15Rarity96")


class RealmEvents: Object {
    dynamic var id: Int = 0
    dynamic var type: String = ""
    dynamic var time: String = ""
    dynamic var userid: Int = 0
    
    override static func primaryKey() -> String?{
        return "id"
    }

}

class Events {
    var type: String
    var time: Date
    init() {
        self.time = Date()
        self.type = ""
    }
    init(type: String) {
        self.type = type
        self.time = Date()
    }
    init(type: String, time: Date) {
        self.type = type
        self.time = time
    }
}
