//
//  ChatModelManager.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 10/1/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation
class ChatModelManager{
    let backendless = Backendless.sharedInstance()!
    var chatDataStore:IDataStore!
    var chatArray:[ChatModel] =  []
    static var shared:ChatModelManager = ChatModelManager()
    private init(){
        chatDataStore = backendless.data.of(ChatModel.self)
    }
    subscript(index:Int) -> ChatModel {
        return chatArray[index]
    }
    func addMessage(_ chat:ChatModel) -> ChatModel{
        chatArray.append(chat)
        let chatObj = saveChat(chat)
        return chatObj
    }
    func saveChat(_ chat:ChatModel) -> ChatModel{
        
        let result:ChatModel = chatDataStore.save(chat) as! ChatModel
        return result
    }
    
//    func assign(invitation:InvitationModel, To event:EventModel, andTo contact:ContactModel){
//        let invitationObj = self.invitationsDataStore.save(invitation) as! InvitationModel
//        self.invitationsDataStore.addRelation("invitationsList:EventModel:n", parentObjectId: invitationObj.objectId!, childObjects: [event.objectId!], response: {(NSNumber) in
//            print(NSNumber!)
//        }, error: { (fault:Fault?) in
//            print("Error occured in events", (fault?.message!)!)
//        })
//        self.invitationsDataStore.addRelation("invitationsContacts:ContactModel:n", parentObjectId: invitationObj.objectId!, childObjects: [contact.objectId!], response: { (NSNumber) in
//            print(NSNumber!)
//        }, error: { (fault:Fault?) in
//            print("Error occured in contacts", (fault?.message!)!)
//        })
//
//    }
    
//    func retrieveAllInvitations(){
//        Types.tryblock({
//            let queryBuilder:DataQueryBuilder = DataQueryBuilder()
//            queryBuilder.setPageSize(100)
//            let result = self.invitationsDataStore.find(queryBuilder) as! [InvitationModel]
//            self.invitationsArray = result
//        },
//                       catchblock: {(exception) -> Void in
//                        print("Error getting contatcs",exception!)
//        })
//
//    }
    
    
    func retrieveChatById(_ id:String) -> [ChatModel]{
        var chatArray:[ChatModel] = []
        Types.tryblock({
            let whereClause = "senderId = '" + id + "'"
            let queryBuilder:DataQueryBuilder = DataQueryBuilder()
            queryBuilder.setWhereClause(whereClause)
            chatArray = self.chatDataStore.find(queryBuilder) as! [ChatModel]
        }) { (exception) in
            print(exception.debugDescription)
        }
        return chatArray
    }
    
}
