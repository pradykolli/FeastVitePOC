//
//  ContactModelManager.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 7/16/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation
import UIKit

@objcMembers
class ContactModelManager{
    let backendless = Backendless.sharedInstance()!
    var contactDataStore:IDataStore!
    var contactsArray:[ContactModel] =  []
    static var shared:ContactModelManager = ContactModelManager()
    private init(){
        contactDataStore = backendless.data.of(ContactModel.self)
    }
    subscript(index:Int) -> ContactModel {
        return contactsArray[index]
    }
    func addContact(_ contact:ContactModel) -> ContactModel{
        contactsArray.append(contact)
        let savedContactObj = saveContact(contact)
        return savedContactObj
    }
    func saveContact(_ contact:ContactModel) -> ContactModel{
        
        let result:ContactModel = contactDataStore.save(contact) as! ContactModel
        return result
    }
    func assign(contact:ContactModel, To contactGroup:ContactGroupModel){
        let contactObj = self.contactDataStore.save(contact) as! ContactModel
        self.contactDataStore.addRelation("contactList:ContactGroupModel:n", parentObjectId: contact.objectId, childObjects: [contactObj.objectId!])
    }
    func deleteContact(_ contact:ContactModel){
        contactDataStore.remove(byId: contact.objectId)
    }
    func retrieveAllContacts(){
        Types.tryblock({
            let queryBuilder:DataQueryBuilder = DataQueryBuilder()
            queryBuilder.setPageSize(100)
            let result = self.contactDataStore.find(queryBuilder) as! [ContactModel]
            self.contactsArray = result
        },
                       catchblock: {(exception) -> Void in
                        print("Error getting contatcs",exception!)
        })
        
    }
}
