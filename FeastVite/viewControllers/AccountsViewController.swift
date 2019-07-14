//
//  AccountsViewController.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 7/9/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit
import Contacts
class AccountsViewController: UIViewController {
    var backendless:Backendless!
    var alerts:AlertErrors = AlertErrors()
    var contcatsDataStore:IDataStore!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in accounts")
        backendless = Backendless.sharedInstance()!
        // Do any additional setup after loading the view.
    }
    
    @IBAction func importContactsBtn(_ sender: Any) {
        let store = CNContactStore()
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey,CNContactNicknameKey]
        do{
            try store.enumerateContacts(with: CNContactFetchRequest.init(keysToFetch: keysToFetch as [CNKeyDescriptor]), usingBlock: { (contact, pointer) -> Void in
                print("contact = ","\(contact)")
                
            })
        }
        catch{
            print("something wrong happened")
        }

    }
    @IBAction func logOutBTN(_ sender: Any) {
        backendless.userService.logout({
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
