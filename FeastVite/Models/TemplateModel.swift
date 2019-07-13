//
//  TemplateModel.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 7/9/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation
import UIKit

@objcMembers
class TemplateModel : NSObject {
    
    var backendless = Backendless.sharedInstance()
    var templateDataStore:IDataStore!
    var templateImage:String!
    var templateName:String!
    var objectId:String?
    private static var _shared:TemplateModel!
    static var shared:TemplateModel{
        if _shared == nil {
            _shared = TemplateModel()
        }
        return _shared
    }
    private override init(){
        templateDataStore = backendless!.data.of(TemplateModel.self)
    }
    init(){
        templateImage = ""
        templateName = "New Template"
    }
}
