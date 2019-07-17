//
//  InvitationModel.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 7/16/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation

@objcMembers
class InvitationModel : NSObject {
    
    var backendless = Backendless.sharedInstance()
    var invitationsDataStore:IDataStore!
    var eventID:String!
    var hostID:String!
    var inviteeID:String!
    var objectId:String?
    private static var _shared:InvitationModel!
    static var shared:InvitationModel{
        if _shared == nil {
            _shared = InvitationModel()
        }
        return _shared
    }
    
    override init(){
        self.eventID = ""
        self.hostID = ""
        self.inviteeID = ""
    }
}
