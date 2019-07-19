//
//  ContactsModel.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 7/15/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation
@objcMembers
class ContactModel : NSObject {
    
    var backendless = Backendless.sharedInstance()
    var contactsDataStore:IDataStore!
    var emailAddress:String!
    var name:String!
    var phone:String!
    var invitationsContacts:[InvitationModel] = []
    var isValidUser:Bool = false
    var userId:String!
    var objectId:String?
    private static var _shared:ContactModel!
    static var shared:ContactModel{
        if _shared == nil {
            _shared = ContactModel()
        }
        return _shared
    }
    
    override init(){
        name = ""
        emailAddress = "test@gmail.com"
        phone = ""
    }
}

@objcMembers
class ContactGroupModel : NSObject {
    
    var backendless = Backendless.sharedInstance()
    var ContactGroupDataStore:IDataStore!
    var groupName:String!
    var contactList:[ContactModel] = []
    var objectId:String?
    private static var _shared:ContactGroupModel!
    static var shared:ContactGroupModel{
        if _shared == nil {
            _shared = ContactGroupModel()
        }
        return _shared
    }
    
    override init(){
        groupName = "All Contacts"
    }
}
