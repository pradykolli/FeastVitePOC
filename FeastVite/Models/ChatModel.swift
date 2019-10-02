//
//  ChatModel.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 10/1/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation
import UIKit

@objcMembers
class ChatModel : NSObject {
    
    var backendless = Backendless.sharedInstance()
    var chatDataStore:IDataStore!
    var senderId:String! //ObjectID of logged in guy
    var recieverId:String!
    var message:String?
    var eventId:String?
    private static var _shared:ChatModel!
    static var shared:ChatModel{
        if _shared == nil {
            _shared = ChatModel()
        }
        return _shared
    }
    
    override init(){
        message = ""
        senderId = ""
        recieverId = ""
    }
}
