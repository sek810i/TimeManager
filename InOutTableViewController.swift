//
//  InOutTableViewController.swift
//  TimeManager
//
//  Created by Богдан Олег on 22.01.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import RealmSwift



class InOutTableViewController: UITableViewController {
    
    
    @IBOutlet weak var EventSelect: UISegmentedControl!
    @IBOutlet weak var TimeSelect: UIDatePicker!
    
    let realm = try! Realm()
    let LoadEvents = LoadData()
    var file = FilePlist()
    var IPath: IndexPath = []
    var realmEvents = List<RealmEvents>()
    var events = [Events]()
    var arrEvents = [(String, String, String)]()
    
    
    @IBAction func AddEvent(_ sender: Any) {
        let event = Events()

        switch EventSelect.selectedSegmentIndex {
        case 0:
            event.type = "Вход"
        case 1:
            event.type = "Выход"
        default:
            self.present(ShowMessage.print(stitle: "Ошибка", smessage: "Не выбран вход или выход", buttontext: "ОК"), animated: true, completion: nil)
        }
        event.time = TimeSelect.date
        let dformat = DateFormatter()
        dformat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dformat.locale = Locale.init(identifier: "RU")

        if event.type != ""{
            let curUser = self.realm.objects(CurUser.self)
            NewEvent.addEvent(type: event.type, time: dformat.string(from: event.time), userId: (curUser.last?.id)!)
            self.tableView.reloadData()
            performSegue(withIdentifier: "goBack", sender: self)        }
    }
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", abs(hours), abs(minutes), abs(seconds))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let load = LoadData()
        arrEvents = [(String, String, String)]()
        let dformat = DateFormatter()
        let now = Date()
        dformat.dateFormat = "yyyy-MM-dd"
        dformat.locale = Locale.init(identifier: "RU")
        
        events = load.loadEventsToUser()
        
        let todayEvents = events.filter {
            (e) -> Bool in
            if dformat.string(from: e.time) == dformat.string(from: now){
                return true
            } else {
                return false
            }
        }
        dformat.dateFormat = "HH:mm:ss"
        if todayEvents.count != 0 {
            var tmptime:Date = dformat.date(from: "00:00:00")!
            var i: Int = 1
            for event in todayEvents {
                if i % 2 != 0 {
                    tmptime = event.time
                    i += 1
                } else {
                    if i % 2 == 0{
                        arrEvents.append((dformat.string(from: tmptime),
                                          dformat.string(from: event.time),
                                          stringFromTimeInterval(
                                            interval: event.time.timeIntervalSince(tmptime))
                        ))
                        tmptime = dformat.date(from: "00:00:00")!
                        i += 1
                    }
                    
                }
            }
            if tmptime != dformat.date(from: "00:00:00")! {
                arrEvents.append((dformat.string(from: tmptime),"нет",""))
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(arrEvents.count)
        return arrEvents.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "store", for: indexPath) as! InOutCell
        cell.timeIn?.text = arrEvents[indexPath.row].0
        cell.timeOut?.text = arrEvents[indexPath.row].1
        cell.timeWork?.text = arrEvents[indexPath.row].2
        //cell.detailTextLabel?.text = String(describing: LoadEvents.events_db[indexPath.row].Time)
        //cell.viewWithTag(1)
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goBack" {
            let controller = segue.destination as! ViewController
            let ld = LoadData()
            controller.EventList = ld.loadEventsToUser()
            controller.viewDidLoad()
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
