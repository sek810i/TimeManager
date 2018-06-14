//
//  InfoView.swift
//  TimeManager
//
//  Created by Богдан Олег on 11.05.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import UIKit

class InfoView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exitUser(_ sender: Any) {
        let input = Input()
        input.logout()
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
