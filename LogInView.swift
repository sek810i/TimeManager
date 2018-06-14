//
//  LogInView.swift
//  TimeManager
//
//  Created by Богдан Олег on 10.05.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit

class LogInView: UIViewController {
    
    var aut = Input()
    
    @IBOutlet weak var fieldLogin: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Login(_ sender: Any) {
        if fieldLogin.text?.isEmpty == true || fieldPassword.text?.isEmpty == true {
            self.present(ShowMessage.print(stitle: "Упс", smessage: "Пустые поля\nЗаполните их чем-нибудь", buttontext: "ОК"), animated: true, completion: nil)
        } else {
            let user = UserName(login: fieldLogin.text!, password: fieldPassword.text!, id: 0)
            if aut.checkLogin(user: user) {
                aut.userLogIn(user: user)
                performSegue(withIdentifier: "userIn", sender: self)
            }
            else {
                self.present(ShowMessage.print(stitle: "Упс", smessage: "Нет такого пользователя", buttontext: "ОК"), animated: true, completion: nil)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
