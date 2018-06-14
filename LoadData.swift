//
//  LoadData.swift
//  TimeManager
//
//  Created by Богдан Олег on 22.01.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class LoadData{
    
    let realm = try! Realm()
    var file = FilePlist()
    var dbcon = DbCon()
    
    func loadEventsToUser() -> [Events] {
        let dformat = DateFormatter()
        dbcon.loadEventsJSON()
        dformat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dformat.locale = Locale.init(identifier: "Rus")
        let user = self.realm.objects(CurUser.self)
        var events = [Events]()
        let rEvents = self.realm.objects(RealmEvents.self).filter { i in i.userid == user.last?.id}
        for rEvent in rEvents {
            let event = Events()
            event.time = dformat.date(from: rEvent.time)!
            event.type = rEvent.type
            events.append(event)
        }
        return events
    }
    
    func loadFreeDays() -> [FreeDay] {
        dbcon.loadFreeDayJSON()
        var freeDays = [FreeDay]()
        let rFreeDays = self.realm.objects(RealmFreeDay.self)
        for rFreeDay in rFreeDays {
            let freeDay = FreeDay()
            freeDay.date = rFreeDay.date
            freeDay.type = rFreeDay.type
            freeDays.append(freeDay)
        }
        return freeDays
    }
}
