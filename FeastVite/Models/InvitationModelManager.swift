//
//  InvitationModelManager.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 7/17/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation

@objcMembers
class InvitationModelManager{
    let backendless = Backendless.sharedInstance()!
    var invitationsDataStore:IDataStore!
    var invitationsArray:[InvitationModel] =  []
    static var shared:InvitationModelManager = InvitationModelManager()
    private init(){
        invitationsDataStore = backendless.data.of(InvitationModel.self)
    }
    subscript(index:Int) -> InvitationModel {
        return invitationsArray[index]
    }
    func addInvitation(_ invitation:InvitationModel) -> InvitationModel{
        invitationsArray.append(invitation)
        let savedinviteObj = saveInvitation(invitation)
        return savedinviteObj
    }
    func saveInvitation(_ invitation:InvitationModel) -> InvitationModel{
        
        let result:InvitationModel = invitationsDataStore.save(invitation) as! InvitationModel
        return result
    }
    func send(invitation:InvitationModel, To contact:ContactModel){
        let invitationObj = self.invitationsDataStore.save(InvitationModel.self) as! InvitationModel
        self.invitationsDataStore.addRelation("invitationsList:ContactModel:n", parentObjectId: contact.objectId, childObjects: [invitationObj.objectId!])
    }
    func deleteContact(_ contact:InvitationModel){
        invitationsDataStore.remove(byId: contact.objectId)
    }
    func retrieveAllContacts(){
        Types.tryblock({
            let queryBuilder:DataQueryBuilder = DataQueryBuilder()
            queryBuilder.setPageSize(100)
            let result = self.invitationsDataStore.find(queryBuilder) as! [InvitationModel]
            self.invitationsArray = result
        },
       catchblock: {(exception) -> Void in
            print("Error getting contatcs",exception!)
        })
        
    }
}