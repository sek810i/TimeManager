//
//  NewEvent.swift
//  TimeManager
//
//  Created by Богдан Олег on 12.05.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import SwiftyJSON

class NewEvent {
    let realm = try! Realm()
    
    class func addEvent(type: String, time: String, userId: Int) {
    
        let url = "http://bookshop.sek810i.ru/addevent.php"
        let param = ["type":type,"time":time,"userid":userId] as [String : Any]
        
        _ = Alamofire.request(url,parameters: param)
        
        let dbase = DbCon()
        dbase.loadEventsJSON()
        
    }
    
}
