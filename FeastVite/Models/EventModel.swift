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
    let backendless = Backendless.sharedInstance()!
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
    override init(){
        self.address = ""
        self.dateAndTime = ""
        self.eventType = ""
        self.personalMessage = ""
        self.phone = ""
        self.venue = ""
    }
}
