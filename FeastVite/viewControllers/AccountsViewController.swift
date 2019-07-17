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
    var contactsDataStore:IDataStore!
    var importedContacts:[CNContact] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in accounts")
        backendless = Backendless.sharedInstance()!
        contactsDataStore = backendless.data.of(ContactModel.self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func importContactsBtn(_ sender: Any) {
        let store = CNContactStore()
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey,CNContactNicknameKey, CNContactEmailAddressesKey]
        do{
            try store.enumerateContacts(with: CNContactFetchRequest.init(keysToFetch: keysToFetch as [CNKeyDescriptor]), usingBlock: { (contact, pointer) -> Void in
//                print("contact = ","\(contact.emailAddresses)")
                self.importedContacts.append(contact)
                
            })
            print("imported contacts count", importedContacts.count)
            for index in 0..<importedContacts.count - 1{
                let contactObj:ContactModel = ContactModel()
                contactObj.name = importedContacts[index].givenName + " " + importedContacts[index].familyName
                contactObj.emailAddress = importedContacts[index].emailAddresses[0].value as String
                contactObj.phone = importedContacts[index].phoneNumbers[0].value.stringValue
                contactsDataStore.save(contactObj)
                ContactModelManager.shared.contactsArray.append(contactObj)
//                print("\n",contactObj.emailAddress)
            }
        }
        catch{
            print("something wrong happened")
        }

    }
    @IBAction func logOutBTN(_ sender: Any) {
        backendless.userService.logout({
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeNavController = storyboard.instantiateViewController(withIdentifier: "homeNavController") as! UINavigationController
            self.present(homeNavController, animated: true, completion: nil)
            
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
