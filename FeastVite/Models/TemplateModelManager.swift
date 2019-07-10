//
//  TemplateModelManager.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 7/9/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation
import UIKit

class TemplateModelManager{
    let backendless = Backendless.sharedInstance()!
    var templatesDataStore:IDataStore!
    var templatesArray:[TemplateModel] =  []
    static var shared:TemplateModelManager = TemplateModelManager()
    
    private init(){
        templatesDataStore = backendless.data.of(TemplateModel.self)
    }
    subscript(index:Int) -> TemplateModel {
        return templatesArray[index]
    }
    func addTemplate(template:TemplateModel){
        let newTemplate = template
        templatesArray.append(newTemplate)
        saveTemplate(withTemplate: template)
    }
    func saveTemplate(withTemplate:TemplateModel){
        templatesDataStore.save(withTemplate)
    }
    func retrieveAllTemplates(){
        Types.tryblock({
            let queryBuilder:DataQueryBuilder = DataQueryBuilder()
            queryBuilder.setPageSize(100)
            let result = self.templatesDataStore.find(queryBuilder) as! [TemplateModel]
            self.templatesArray = result
        },
    catchblock: {(exception) -> Void in
        print("Error gettiing scores")
    })
    
    }
}
