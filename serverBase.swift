//
//  serverBase.swift
//  TimeManager
//
//  Created by Богдан Олег on 10.05.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import RealmSwift


class DbCon {
    
    let realm = try! Realm()
    var file = FilePlist()
    
    func loadUsersJSON() {
        
        let rUsers = List<RealmUserName>()
        let url = "http://bookshop.sek810i.ru/SelectTM.php"
        let param = ["table":"Users"]
        
        Alamofire.request(url, parameters: param).validate().responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json.count)
                for(_,subJson):(String,JSON) in json{
                    let rUser = RealmUserName()
                    rUser.id = subJson["id"].intValue
                    rUser.name = subJson["name"].stringValue
                    rUser.fam = subJson["fam"].stringValue
                    rUser.otch = subJson["otch"].stringValue
                    rUser.email = subJson["email"].stringValue
                    rUser.password = subJson["password"].stringValue
                    rUsers.append(rUser)
                }
                try! self.realm.write {
                    self.realm.add(rUsers, update: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadEventsJSON() {
        
        let rEvents = List<RealmEvents>()
        let url = "http://bookshop.sek810i.ru/SelectTM.php"
        let param = ["table":"events"]
        
        Alamofire.request(url, parameters: param).validate().responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                for(_,subJson):(String,JSON) in json{
                    let rEvent = RealmEvents()
                    rEvent.id = subJson["id"].intValue
                    rEvent.time = subJson["time"].stringValue
                    rEvent.type = subJson["type"].stringValue
                    rEvent.userid = subJson["userId"].intValue
                    rEvents.append(rEvent)
                }
                try! self.realm.write {
                    self.realm.add(rEvents, update: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func loadFreeDayJSON() {
        
        let rFreeDays = List<RealmFreeDay>()
        let url = "http://bookshop.sek810i.ru/SelectTM.php"
        let param = ["table":"freeday"]
        
        Alamofire.request(url, parameters: param).validate().responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                for(_,subJson):(String,JSON) in json{
                    let rFreeDay = RealmFreeDay()
                    rFreeDay.id = subJson["id"].intValue
                    rFreeDay.date = subJson["date"].stringValue
                    rFreeDay.type = subJson["type"].intValue
                    rFreeDays.append(rFreeDay)
                }
                try! self.realm.write {
                    self.realm.add(rFreeDays, update: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
