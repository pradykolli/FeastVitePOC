//
//  RSVPModel.swift
//  FeastVitePOC
//
//  Created by Student on 9/9/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation

@objcMembers
class Rsvp:NSObject {
    static let shared = Rsvp()
    var guestCount:Int?
    var backendless = Backendless.sharedInstance()
    var eventDataStore:IDataStore!
    var RsvpDataStore:IDataStore!
    var objectId:String?

    private override init() {
        self.RsvpDataStore = backendless?.data.of(Rsvp.self)
    }
    
//    init(guestcount:Int){
//        self.guestCount = guestcount
//    }
}
