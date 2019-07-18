//
//  ViewController.swift
//  FeastVitePOC
//
//  Created by student on 6/13/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var eventLBL: UILabel!
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
        
        let invitation = InvitationModelManager.shared.invitationsArray[0]
        print(invitation)
        let event:EventModel = eventDataStore.find(byId: invitation.eventID) as! EventModel
        print(event)
//        let template:TemplateModel = event.eventInviteTemplate
//        print(template.templateImage)
        
        
//        eventLBL.text = event.eventType
//        let template = abc.eventInviteTemplate
//        imageView.image = TemplateModelManager.shared.getImage(fromTemplateURL: template.templateImage)
    }


}

