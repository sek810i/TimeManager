//
//  OtchotTableView.swift
//  TimeManager
//
//  Created by Богдан Олег on 13.05.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit

class OtchotTableView: UITableViewController {
    
    var modelArray = [String]()
    var statToDays = [(String,String,String,String)]()
    var statToDay = [(String,String,String)]()
    var indexToStat: Int = 0
    
    func replaceInputFormat(date: String) -> String {
        if date.contains("-"){
            let dform = DateFormatter()
            dform.dateFormat = "yyyy-MM-dd"
            dform.locale = Locale(identifier: "RU")
            let tmpdate = dform.date(from: date)
            dform.dateFormat = "dd.MM.yyyy"
            return dform.string(from: tmpdate!)
        } else {
            return date
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

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
        switch indexToStat {
        case 1:
            return statToDay.count
        case 2:
            return statToDays.count
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! StatCell
        switch indexToStat {
        case 1:
            cell.textDate.isHidden = true
            cell.textIn?.text = statToDay[indexPath.row].0
            cell.textOut?.text = statToDay[indexPath.row].1
            cell.textTime?.text = statToDay[indexPath.row].2
            if indexPath.row == statToDay.count-1 {
                cell.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            } else {
                cell.backgroundColor = #colorLiteral(red: 0.943475008, green: 1, blue: 1, alpha: 1)
            }
        case 2:
            cell.textDate.isHidden = false
            cell.textDate?.text = replaceInputFormat(date: statToDays[indexPath.row].0)
            cell.textIn?.text = statToDays[indexPath.row].1
            cell.textOut?.text = statToDays[indexPath.row].2
            cell.textTime?.text = statToDays[indexPath.row].3
            if indexPath.row == statToDays.count-1 {
                cell.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            } else {
                cell.backgroundColor = #colorLiteral(red: 0.943475008, green: 1, blue: 1, alpha: 1)
            }
        default:
            cell.textTime?.text = "Хрень"
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
