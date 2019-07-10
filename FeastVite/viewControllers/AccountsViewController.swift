//
//  AccountsViewController.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 7/9/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class AccountsViewController: UITabBarController {
    var backendless:Backendless!
    var alerts:AlertErrors = AlertErrors()

    override func viewDidLoad() {
        super.viewDidLoad()
        backendless = Backendless.sharedInstance()!

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutBTN(_ sender: Any) {
        backendless.userService.logout({
            self.navigationController?.popToRootViewController(animated: true)
        }) { (fault:Fault?) in
            self.alerts.displayAlert("Server Error", (fault?.message)!)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
