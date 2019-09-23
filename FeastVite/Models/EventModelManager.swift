//
//  EventModelManager.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 7/11/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation
import UIKit

@objcMembers
class EventModelManager{
    let backendless = Backendless.sharedInstance()!
    var eventDataStore:IDataStore!
    var templatesDataStore:IDataStore!
    var eventsArray:[EventModel] =  []
    let currentUser:BackendlessUser!
    static var shared:EventModelManager = EventModelManager()
    var eventObj:EventModel!
    private init(){
        eventDataStore = backendless.data.of(EventModel.self)
        templatesDataStore = backendless.data.of(TemplateModel.self)
        currentUser = backendless.userService.currentUser

    }
    subscript(index:Int) -> EventModel {
        return eventsArray[index]
    }
    func addEvent(eventOf:EventModel) -> EventModel{
        eventsArray.append(eventOf)
        eventObj = eventOf
        let savedEventObj = saveEvent(withEvent: eventOf)
        print("app enetered added the event")
        return savedEventObj
    }
    func saveEvent(withEvent:EventModel) -> EventModel{
//        let savedEventObj =  eventDataStore!.save(withEvent, response: {
//            (withEvent) -> EventModel in
//            print("withEvent saved")
//            return withEvent
//        },
//        error: {
//            (fault : Fault?) -> () in
//            print("Server reported an error: \(String(describing: fault))")
//        })
//        print("app enetered saved the event")
        let result:EventModel = eventDataStore.save(withEvent) as! EventModel
        return result
    }
    func assign(event:EventModel, invitationTemplate:TemplateModel){
        let templateObj = self.templatesDataStore.save(invitationTemplate) as! TemplateModel
        self.eventDataStore.addRelation("eventInviteTemplate:TemplateModel:1", parentObjectId: event.objectId, childObjects: [templateObj.objectId!])
    }
    func retrieveAllEvents(){
        Types.tryblock({
            let whereClause = "ownerId = '" + (self.currentUser.objectId! as String) + "'"
            let queryBuilder:DataQueryBuilder = DataQueryBuilder()
            queryBuilder.setPageSize(100)
            queryBuilder.setWhereClause(whereClause)
            let result = self.eventDataStore.find(queryBuilder) as! [EventModel]
            self.eventsArray = result
        },
                       catchblock: {(exception) -> Void in
                        print("Error gettiing Templates")
        })
        
    }
    func getTemplate(relatedto event:EventModel) -> TemplateModel{
        let dataStore = backendless.data.of(EventModel.self)
        
        // Prepare LoadRelationsQueryBuilder
        let loadRelationsQueryBuilder = LoadRelationsQueryBuilder.of(TemplateModel.self)
        loadRelationsQueryBuilder!.setRelationName("eventInviteTemplate")
        
        let objectId = event.objectId// removed for brevity
        
        let templates = dataStore!.loadRelations(objectId, queryBuilder: loadRelationsQueryBuilder) as! [TemplateModel]
        return templates[0]
        
    }
    func deleteTemplatesOrTemplate(_ id:String){
                Types.tryblock({
                    let dataStore = self.backendless.data.of(EventModel.self)
        let loadRelationsQueryBuilder = LoadRelationsQueryBuilder.of(TemplateModel.self)
        loadRelationsQueryBuilder!.setRelationName("eventInviteTemplate")
        let data = dataStore?.loadRelations(id, queryBuilder: loadRelationsQueryBuilder) as! [TemplateModel]
        print(data[0].objectId as Any)
        TemplateModelManager.shared.templatesDataStore.remove(data[0].objectId!)
        self.eventDataStore.remove(id)
        
                }) { (exception) in
                    print(exception.debugDescription)
                }
    
        
    }

}
