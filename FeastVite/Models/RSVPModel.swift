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
    var guestCount:Int?
    var backendless = Backendless.sharedInstance()
    var eventDataStore:IDataStore!
    var objectId:String?

    override init(){
        self.guestCount = 0
    }
}
