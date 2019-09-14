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
    var eventsHosted:[EventModel] = []
    var backendless:Backendless! = Backendless.sharedInstance()
    var invitationsDataStore:IDataStore!
    var eventDataStore:IDataStore!
    var templateDataStore:IDataStore!
    var sections = ["Hosted Events", "Invited Events"]
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
        invitationsRecieved = InvitationModelManager.shared.retrieveInvitationsRecievedTo(currentUser.objectId! as String)
        eventsHosted = EventModelManager.shared.eventsArray
        print(eventsHosted.count)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows'
        if section == 0{
            return eventsHosted.count
        }
        else{
            return invitationsRecieved.count}
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvitationCell", for: indexPath)
        if indexPath.section == 1 {
        let invitations:[InvitationModel] = InvitationModelManager.shared.invitationsRecievedArray
        let event:EventModel = eventDataStore.find(byId: invitations[indexPath.row].eventID) as! EventModel
        cell.textLabel?.text = event.eventType
        let template = EventModelManager.shared.getTemplate(relatedto: event)
        cell.detailTextLabel?.text = template.templateName
       
        }
        else{
            let hosted:[EventModel] = EventModelManager.shared.eventsArray
            let hostEvent = eventDataStore.find(byId: hosted[indexPath.row].objectId) as! EventModel
            cell.textLabel?.text = hostEvent.eventType
            cell.detailTextLabel?.text = EventModelManager.shared.getTemplate(relatedto: hostEvent).templateName
        }
         return cell
    }
 
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section{
        case 0:
            print("Hello")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let hosted = storyboard.instantiateViewController(withIdentifier: "HostedDetails") as! HostedDetailsViewController
            self.navigationController?.pushViewController(hosted, animated: true)

        case 1:
            let value = invitationsRecieved[indexPath.row].eventID
//            RSVPViewController.shared.imagePreview = value
            print(value)
            let image = InvitationModelManager.shared.retrieveTemplateById(value!)
            let imageData = TemplateModelManager.shared.getImage(fromTemplateURL: image[0].eventID)
            RSVPViewController.shared.image = imageData
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let current = storyboard.instantiateViewController(withIdentifier: "RSVP") as! RSVPViewController
            self.navigationController?.pushViewController(current, animated: true)

        default:
            break
        }
//        self.performSegue(withIdentifier: identifierForView!, sender: self)
        
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
