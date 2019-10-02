//
//  chatContactsTableViewController.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 9/22/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class ChatContactsTableViewController: UITableViewController {
    
    var clickedContact:ContactModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         ContactModelManager.shared.retrieveAllContacts()
        self.navigationItem.title = "Select a contact"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return ContactModelManager.shared.contactsArray.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactDetail", for: indexPath)
        //         Configure the cell...
        cell.textLabel?.text = ContactModelManager.shared.contactsArray[indexPath.row].name
        cell.detailTextLabel?.text = ContactModelManager.shared.contactsArray[indexPath.row].emailAddress
        return cell
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "ChatWithContact"{
            let indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
            
            self.clickedContact = ContactModelManager.shared.contactsArray[indexPath.row]
            let destinationVC = segue.destination as! ChatViewController
            
            // Pass the selected object to the new view controller.
            destinationVC.recieverUser = clickedContact.emailAddress
        }
    }
 

}
