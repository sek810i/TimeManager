//
//  GetStatToDate.swift
//  TimeManager
//
//  Created by Богдан Олег on 14.05.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import Foundation

class GetStat {
    
    let lDate = LoadData()
    
    func getFormatDate() -> DateFormatter {
        let dFormat = DateFormatter()
        dFormat.dateFormat = "yyyy-MM-dd"
        dFormat.locale = Locale(identifier: "RU")
        return dFormat
    }
    
    func replaceInputFormat(date: String) -> String {
        if date.contains("."){
            let dform = DateFormatter()
            dform.dateFormat = "dd.MM.yyyy"
            dform.locale = Locale(identifier: "RU")
            let tmpdate = dform.date(from: date)
            dform.dateFormat = "yyyy-MM-dd"
            return dform.string(from: tmpdate!)
        } else {
            return date
        }
    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", abs(hours), abs(minutes), abs(seconds))
    }
    
    func toDay(day: String) -> [(String,String,String)]{
        var arrEvents = [(String,String,String)]()
        let dateFormat = getFormatDate()
        let events = lDate.loadEventsToUser().filter {
            (event) -> Bool in
            if dateFormat.string(from: event.time) == replaceInputFormat(date: day){
                return true
            } else {
                return false
            }
        }
        if events.isEmpty == false {
            dateFormat.dateFormat = "HH:mm:ss"
            var i :Int = 1
            var tmpTime:Date = dateFormat.date(from: "00:00:00")!
            
            for event in events {
                if i % 2 != 0 {
                    tmpTime = event.time
                    i += 1
                } else {
                    if i % 2 == 0 {
                        arrEvents.append((dateFormat.string(from: tmpTime),dateFormat.string(from: event.time),stringFromTimeInterval(interval: event.time.timeIntervalSince(tmpTime))))
                        tmpTime = dateFormat.date(from: "00:00:00")!
                        i+=1
                    }
                }
            }
            if tmpTime != dateFormat.date(from: "00:00:00")! {
                arrEvents.append((dateFormat.string(from: tmpTime),"нет",""))
            }
            let first = events
                .filter { $0.type == "Вход"}
                .sorted { $0.time < $1.time }
                .first
            let last = events
                .filter { $0.type == "Выход"}
                .sorted { $0.time > $1.time }
                .first
            tmpTime = dateFormat.date(from: "00:00:00")!
            var sum = TimeInterval(0)
                for event in arrEvents {
                    if event.1 != "нет" {
                    sum += tmpTime.timeIntervalSince(dateFormat.date(from: event.2)!)
                    }
                }
           
            if last == nil {
                arrEvents.append((dateFormat.string(from: (first?.time)!),"нет",stringFromTimeInterval(interval: sum)))
            } else {
                arrEvents.append((dateFormat.string(from: (first?.time)!),dateFormat.string(from: (last?.time)!),stringFromTimeInterval(interval: sum)))
            }
        }
        return arrEvents
    }
    
    func toDates(startDate: String, endDate: String) -> [(String,String,String,String)] {
        var arrEvents = [(String,String,String,String)]()
        var sumTime = TimeInterval(0)
        let dateFormat = getFormatDate()
        let day: Int = Int((dateFormat.date(from: replaceInputFormat(date: endDate))?.timeIntervalSince((dateFormat.date(from: replaceInputFormat(date: startDate)))!))!) / 86400
        for i in 0...day{
            dateFormat.dateFormat = "yyyy-MM-dd"
            let curDate = dateFormat.date(from: replaceInputFormat(date: startDate))?.addingTimeInterval(TimeInterval(i * 86400))
            let curDateEvents = toDay(day: dateFormat.string(from: curDate!))
            if curDateEvents.isEmpty {
                arrEvents.append((dateFormat.string(from: curDate!),
                                  "",
                                  "",
                                  "нет"))
            } else {
            arrEvents.append((dateFormat.string(from: curDate!),
                              (curDateEvents.last?.0)!,
                              (curDateEvents.last?.1)!,
                              (curDateEvents.last?.2)!))
                if curDateEvents.last?.2 != "" {
                    dateFormat.dateFormat = "HH:mm:ss"
                    sumTime.add((dateFormat.date(from: (curDateEvents.last?.2)!)?.timeIntervalSince(dateFormat.date(from: "00:00:00")!))!)
                }
            }
        }
        arrEvents.append(("Всего","","",stringFromTimeInterval(interval: sumTime)))
        
        
        return arrEvents
    }
}
