//
//  OtchotView.swift
//  TimeManager
//
//  Created by Богдан Олег on 13.05.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit

class OtchotView: UIViewController {
    
    @IBOutlet weak var typeOtch: UISegmentedControl!
    
    @IBOutlet weak var textDate: UITextField!
    
    @IBOutlet weak var textStartDate: UITextField!
    @IBOutlet weak var textEndDate: UITextField!
    
    let dateFormat = DateFormatter()
    
    
    func checkPikcer() {
        switch typeOtch.selectedSegmentIndex {
        case 0:
            textDate.isHidden = false
            textStartDate.isHidden = true
            textEndDate.isHidden = true
        case 1:
            textDate.isHidden = true
            textStartDate.isHidden = false
            textEndDate.isHidden = false
        default:
            textDate.isHidden = true
            textStartDate.isHidden = true
            textEndDate.isHidden = true
        }
    }
    @IBAction func changePick(_ sender: Any) {
        checkPikcer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkPikcer()
        dateFormat.dateStyle = DateFormatter.Style.medium
        dateFormat.timeStyle = DateFormatter.Style.none
        dateFormat.dateFormat = "dd.MM.yyyy"
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func beginEdit(_ sender: UITextField) {
        let dpick = UIDatePicker()
        dpick.datePickerMode = UIDatePickerMode.date
        dpick.setValue(#colorLiteral(red: 0, green: 0.2941176471, blue: 0.5215686275, alpha: 1), forKey: "textColor")
        dpick.locale = NSLocale.init(localeIdentifier: "RU") as Locale
        sender.inputView = dpick
        dpick.maximumDate = Date()
        switch sender {
        case textDate:
            dpick.addTarget(self, action: #selector(datePikerValueChange1), for: UIControlEvents.valueChanged)
        case textStartDate:
            if textEndDate?.text?.isEmpty == false {
                dpick.maximumDate = dateFormat.date(from: (textEndDate?.text)!)?.addingTimeInterval(-1440)
            }
            dpick.addTarget(self, action: #selector(datePikerValueChange2), for: UIControlEvents.valueChanged)
        case textEndDate:
            if (textStartDate?.text?.isEmpty)! == false {
                dpick.minimumDate = dateFormat.date(from: (textStartDate?.text)!)?.addingTimeInterval(1440)
            }
            dpick.addTarget(self, action: #selector(datePikerValueChange3), for: UIControlEvents.valueChanged)
        default:
            print("УПС")
        }
        // dpick.addTarget(self, action: #selector(datePikerValueChange), for: UIControlEvents.valueChanged)
        let bar = UIToolbar()
        bar.barStyle = .default
        bar.tintColor = #colorLiteral(red: 0, green: 0.2941176471, blue: 0.5215686275, alpha: 1)
        bar.sizeToFit()
        var doneItem = UIBarButtonItem()
        switch sender {
        case textDate:
            doneItem = UIBarButtonItem(title: "Готово", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneEdit1))
        case textStartDate:
            doneItem = UIBarButtonItem(title: "Готово", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneEdit2))
        case textEndDate:
            doneItem = UIBarButtonItem(title: "Готово", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneEdit3))
        default:
            print("УПС")
        }
        bar.setItems([doneItem], animated: false)
        bar.isUserInteractionEnabled = true
        sender.inputAccessoryView = bar
    }
    
    func doneEdit1() {
        textDate.resignFirstResponder()
    }
    func doneEdit2() {
        textStartDate.resignFirstResponder()
    }
    func doneEdit3() {
        textEndDate.resignFirstResponder()
    }
    
    func datePikerValueChange1(sender: UIDatePicker) {
        textDate.text = dateFormat.string(from: sender.date)
    }
    func datePikerValueChange2(sender: UIDatePicker) {
        textStartDate.text = dateFormat.string(from: sender.date)
    }
    func datePikerValueChange3(sender: UIDatePicker) {
        textEndDate.text = dateFormat.string(from: sender.date)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let sBase = DbCon()
    let lDate = LoadData()
    
    
    
    @IBAction func createStat(_ sender: Any) {
        let tableView = childViewControllers[0] as? OtchotTableView
        
        switch typeOtch.selectedSegmentIndex {
        case 0:
            if (textDate?.text?.isEmpty)! {
                self.present(ShowMessage.print(stitle: "Ошибка", smessage: "Выберете дату для отчёта", buttontext: "Понял, принял"), animated: true, completion: nil)
            } else {
                let getStat = GetStat()
                tableView?.indexToStat = 1
                tableView?.statToDay = getStat.toDay(day: (textDate?.text)!)
                if (tableView?.statToDay.isEmpty)! {
                    present(ShowMessage.print(stitle: "Упс", smessage: "За эту дату нет событий", buttontext: "ОК"), animated: true, completion: nil)
                }
                tableView?.tableView.reloadData()
            }
        case 1:
            if (textStartDate?.text?.isEmpty)! || (textEndDate?.text?.isEmpty)! {
                present(ShowMessage.print(stitle: "Ошибка", smessage: "Одно из полей для дат пустое \n Для вывода отчёта по дням требуется два заполненных поля с датами", buttontext: "Понял, принял"), animated: true, completion: nil)
            } else {
                let getStat = GetStat()
                tableView?.indexToStat = 2
                tableView?.statToDays = getStat.toDates(startDate: (textStartDate?.text)!, endDate: (textEndDate?.text)!)
                if (tableView?.statToDays.isEmpty)! {
                    present(ShowMessage.print(stitle: "Упс", smessage: "За эти даты нет событий", buttontext: "OK"), animated: true, completion: nil)
                }
                tableView?.tableView.reloadData()
            }
        default:
            print("Что то точно идёт не так")
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InfoSegue" {
            let tableView = segue.destination as? OtchotTableView
            tableView?.indexToStat = 0
        }
    }
    
    
}
