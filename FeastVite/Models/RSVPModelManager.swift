//
//  RSVPModelManager.swift
//  FeastVitePOC
//
//  Created by Student on 9/9/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation

@objcMembers
class RSVPModelManager:NSObject{
    static let shared = RSVPModelManager()
    var backenless = Backendless.sharedInstance()!
    var RSVPDataStore:IDataStore!
    override init(){
        self.RSVPDataStore = backenless.data.of(Rsvp.self)
    }
    
    func save(_ rsvp:Rsvp){
        self.RSVPDataStore!.save(rsvp)
    }
}
