//
//  ViewController.swift
//  TimeManager
//
//  Created by Богдан Олег on 22.01.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import RealmSwift

class ViewController: UIViewController {
    
    let realm = try! Realm()
    let LoadEvents = LoadData()
    var file = FilePlist()
    var EventList = [Events]()
    var timer = Timer()
    var isLastIn: Bool = false
    var lastTime = Date()
    let ld = LoadData()
    var freeDays = [FreeDay]()
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBAction func exitUser(_ sender: Any) {
        let input = Input()
        input.logout()
    }
    
    @IBAction func goBack(segue: UIStoryboardSegue){
    }
    
    @IBOutlet weak var TimeToWork: UILabel!
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TimeToWork?.text = getTimeToWork()
        
        freeDays = ld.loadFreeDays()
        
        if isLastIn {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.Updtime), userInfo: nil, repeats: true)
        }
    }
    
    func Updtime() {
        TimeToWork?.text = getTimeToWork()
    }

    func getTimeToWork() -> String {
        var resultString: String = ""
        let dformat = DateFormatter()
        let now = Date()
        dformat.dateFormat = "yyyy-MM-dd"
        dformat.locale = Locale.init(identifier: "RU")
        let getStat = GetStat()
        let events = getStat.toDay(day: dformat.string(from: Date()))
        dformat.dateFormat = "dd.MM.yyyy"
        if freeDays.contains(where: { $0.date == dformat.string(from: Date()) && $0.type == 0 }) {
            dformat.dateFormat = "HH:mm:ss"
            lastTime = dformat.date(from: "00:00:00")!
        } else {
            if freeDays.contains(where: { $0.date == dformat.string(from: Date()) && $0.type == 1 }) {
                dformat.dateFormat = "HH:mm:ss"
                lastTime = dformat.date(from: "07:00:00")!
            } else {
                dformat.dateFormat = "HH:mm:ss"
                lastTime = dformat.date(from: "08:00:00")!
            }
        }
        
        if events.isEmpty {
            resultString = dformat.string(from: lastTime)
        } else {
            
            if events[events.count-2].1 == "нет"{
                var TI = dformat.date(from: (events.last?.2)!)?.timeIntervalSince(dformat.date(from: "00:00:00")!)
                TI?.add((dformat.date(from: dformat.string(from: now))?.timeIntervalSince(dformat.date(from: events[events.count-2].0)!))!)
                if lastTime < dformat.date(from: stringFromTimeInterval(interval: TI!))! {
                    var rt = TimeInterval()
                    print(dformat.string(from: lastTime))
                    switch dformat.string(from: lastTime) {
                    case "08:00:00" :
                        rt = TimeInterval(28800)
                    case "07:00:00" :
                        rt = TimeInterval(25200)
                    default:
                        rt = TimeInterval(0)
                    }
                    lastTime = dformat.date(from: "00:00:00")!
                    print(stringFromTimeInterval(interval: rt))
                    lastTime.addTimeInterval(TI!-rt)
                    mainLabel?.text = "Переработка"
                } else {
                    lastTime.addTimeInterval(-TI!)
                    mainLabel?.text = "Осталось отработать"
                }
                resultString = dformat.string(from: lastTime)
                isLastIn = true
                //print(stringFromTimeInterval(interval: TI!))
            } else {
                let TI = dformat.date(from: (events.last?.2)!)?.timeIntervalSince(dformat.date(from: "00:00:00")!)
                lastTime.addTimeInterval(-TI!)
                if lastTime < dformat.date(from: stringFromTimeInterval(interval: TI!))! {
                    var rt = TimeInterval()
                    switch dformat.string(from: lastTime) {
                    case "08:00:00" :
                        rt = TimeInterval(28800)
                    case "07:00:00" :
                        rt = TimeInterval(25200)
                    default:
                        rt = TimeInterval(0)
                    }
                    lastTime = dformat.date(from: "00:00:00")!
                    lastTime.addTimeInterval(TI!-rt)
                    mainLabel?.text = "Переработка"
                } else {
                    lastTime.addTimeInterval(-TI!)
                    mainLabel?.text = "Осталось отработать"
                }
                resultString = dformat.string(from: lastTime)
                isLastIn = false
            }
        }
        return resultString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

