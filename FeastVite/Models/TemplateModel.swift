//
//  TemplateModel.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 7/9/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation
import UIKit

class TemplateModel : NSObject {
    
    var templateImage:String!
    var templateName:String!
    var eventType:String!
    var eventDateTime:String!
    var eventVenue:String!
    var eventWelcomeMessage:String!
    private static var _shared:TemplateModel!
    static var shared:TemplateModel{
        if _shared == nil {
            _shared = TemplateModel()
        }
        return _shared
    }
    
    override init(){
        templateImage = ""
        templateName = "New Template"
        eventType = "Birthday"
        eventDateTime = "10/10/2019 18:30"
        eventVenue = "1121 N. College Dr, Apt56, Maryville MO 64468"
        eventWelcomeMessage = "It's my birthday, Please Join us for celebrating it together."
    }
}
