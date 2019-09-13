//
//  EventsModel.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 7/11/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation
@objcMembers
class EventModel:NSObject{
    
    private static var _shared:EventModel!
    var backendless = Backendless.sharedInstance()
    var eventDataStore:IDataStore!
    var objectId:String?
    static var shared:EventModel{
        if _shared == nil {
            _shared = EventModel()
        }
        return _shared
    }
    var eventType: String
    var personalMessage: String
    var address: String
    var phone: String
    var venue: String
    var dateAndTime: String
    var eventInviteTemplate: TemplateModel
    var invitationsList:[InvitationModel] = []
    var guestCount:Int
    
    override init(){
        self.address = ""
        self.dateAndTime = ""
        self.eventType = ""
        self.personalMessage = ""
        self.phone = ""
        self.venue = ""
        let templateObj = TemplateModel.shared
        self.eventInviteTemplate = templateObj
        self.guestCount = 0
    }
}
