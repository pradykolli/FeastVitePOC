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
    var eventsArray:[EventModel] =  []
    static var shared:EventModelManager = EventModelManager()
    
    private init(){
        eventDataStore = backendless.data.of(EventModel.self)
    }
    subscript(index:Int) -> EventModel {
        return eventsArray[index]
    }
    func addEvent(eventOf:EventModel){
        eventsArray.append(eventOf)
        saveEvent(withEvent: eventOf)
        print("app enetered added the event")

    }
    func saveEvent(withEvent:EventModel){
        eventDataStore.save(withEvent, response: {
            (withEvent) -> () in
            print("withEvent saved")
        },
        error: {
            (fault : Fault?) -> () in
            print("Server reported an error: \(String(describing: fault))")
        })
        print("app enetered saved the event")

    }
    func assign(event:EventModel, invitationTemplate:TemplateModel){
        let templateObj = TemplateModelManager.shared.templatesDataStore.save(invitationTemplate) as! TemplateModel
        self.eventDataStore.addRelation("event:template:1", parentObjectId: event.objectId, childObjects: [templateObj.objectId!])
        self.addEvent(eventOf: event)
    }
    func retrieveAllTemplates(){
        Types.tryblock({
            let queryBuilder:DataQueryBuilder = DataQueryBuilder()
            queryBuilder.setPageSize(100)
            let result = self.eventDataStore.find(queryBuilder) as! [EventModel]
            self.eventsArray = result
        },
                       catchblock: {(exception) -> Void in
                        print("Error gettiing scores")
        })
        
    }
}
