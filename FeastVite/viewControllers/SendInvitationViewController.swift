//
//  SendInvitationViewController.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 7/17/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class SendInvitationViewController: UIViewController {
    var backendless:Backendless! = Backendless.sharedInstance()
    var contactsDataStore:IDataStore!
    var fetchedContactObj:[ContactModel] = []
    var eventObj:EventModel!
    static var shared:SendInvitationViewController! = SendInvitationViewController()
    @IBOutlet weak var emailTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contactsDataStore = backendless.data.of(ContactModel.self)
        ContactModelManager.shared.retrieveAllContacts()
    }
    

    func fetchingUserId(of invitee:String) -> BackendlessUser {
        var user:[BackendlessUser] = []
        Types.tryblock({ () -> Void in
            let whereClause = "email = '" + invitee + "'"
            let queryBuilder:DataQueryBuilder = DataQueryBuilder()
            queryBuilder.setPageSize(10)
            queryBuilder.setWhereClause(whereClause)
            
            var dataStore = self.backendless.persistenceService.of(BackendlessUser.ofClass())
            user = dataStore!.find(queryBuilder) as! [BackendlessUser]
            print("Users have been fetched (SYNC): \(user[0].objectId!)")
            
        },
                  
           catchblock: { (exception) -> Void in
            print("Server reported an error (SYNC): \(exception as! Fault)")
            }
        )
        return user[0]
    }
    func getContactObj(of email:String) -> [ContactModel]{
        Types.tryblock({
            let queryBuilder:DataQueryBuilder = DataQueryBuilder()
            let whereClause = "emailAddress = '" + email + "'"
            queryBuilder.setPageSize(10)
            queryBuilder.setWhereClause(whereClause)
            let result = self.contactsDataStore.find(queryBuilder) as! [ContactModel]
            self.fetchedContactObj = result
        },
          catchblock: {(exception) -> Void in
            print("Error getting contatcs",exception!)
        })
        return fetchedContactObj
    }
    @IBAction func sendInvitationBTN(_ sender: Any) {
//        let invitationObj:InvitationModel = InvitationModel()
//        let currentUser = backendless.userService.currentUser
//        let emailAddress = emailTF.text!
//        let guest = fetchingUserId(of:emailAddress)
//        let contactOfGuest:[ContactModel] = self.getContactObj(of: emailAddress)
//        if let guestId = guest.objectId{
//            invitationObj.inviteeID = guestId as String
//            invitationObj.hostID = currentUser?.objectId! as String?
//            invitationObj.eventID = eventObj.objectId! as NSString as String
//            InvitationModelManager.shared.send(invitation: invitationObj, To: contactOfGuest[0])
//
//        }
        let invitationObj:InvitationModel = InvitationModel()
        let currentUser = backendless.userService.currentUser
        let emailAddress = emailTF.text!
        let guest = fetchingUserId(of:emailAddress)
        let contactOfGuest:[ContactModel] = self.getContactObj(of: emailAddress)
        if let guestId = guest.objectId{
//      
            invitationObj.inviteeID = guestId as String
            invitationObj.hostID = currentUser?.objectId! as String?
            invitationObj.eventID = eventObj.objectId!
                as String
            InvitationModelManager.shared.assign(invitation: invitationObj, To: eventObj, andTo: contactOfGuest[0])
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
