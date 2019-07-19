//
//  ViewInvitationsTableViewController.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 7/18/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class ViewInvitationsTableViewController: UITableViewController {
    var invitationsRecieved:[InvitationModel] = []
    var backendless:Backendless! = Backendless.sharedInstance()
    var invitationsDataStore:IDataStore!
    var eventDataStore:IDataStore!
    var templateDataStore:IDataStore!
    override func viewDidLoad() {
        super.viewDidLoad()
        invitationsDataStore = backendless.data.of(InvitationModel.self)
        // Do any additional setup after loading the view, typically from a nib.
        eventDataStore = backendless.data.of(EventModel.self)
        templateDataStore = backendless.data.of(TemplateModel.self)
        InvitationModelManager.shared.retrieveAllInvitations()
        EventModelManager.shared.retrieveAllEvents()
        TemplateModelManager.shared.retrieveAllTemplates()
        let currentUser = backendless.userService.currentUser!
        invitationsRecieved = InvitationModelManager.shared.retrieveInvitationsRecievedTo(currentUser.objectId as! String)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return invitationsRecieved.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Hosted events"
        }
        else{
            return "Invited events"
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvitationCell", for: indexPath)
        
        let invitations:[InvitationModel] = InvitationModelManager.shared.invitationsRecievedArray
        print(invitations)
        
        let event:EventModel = eventDataStore.find(byId: invitations[indexPath.row].eventID) as! EventModel
        print(event)
        cell.textLabel?.text = event.eventType
        let template = EventModelManager.shared.getTemplate(relatedto: event)
        cell.detailTextLabel?.text = template.templateName
        // Configure the cell...

        return cell
    }
 
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
