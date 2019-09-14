//
//  TemplateModelManager.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 7/9/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import Foundation
import UIKit

@objcMembers
class TemplateModelManager{
    let backendless = Backendless.sharedInstance()!
    var templatesDataStore:IDataStore!
    var templatesArray:[TemplateModel] =  []
    let currentUser:BackendlessUser!
    static var shared:TemplateModelManager = TemplateModelManager()
    
    private init(){
        templatesDataStore = backendless.data.of(TemplateModel.self)
        currentUser = backendless.userService.currentUser
    }
    subscript(index:Int) -> TemplateModel {
        return templatesArray[index]
    }
    
    func upload(image:UIImage) -> String {
        let textFileName = Float.random(in: 0 ... 100000000)
        let filePath:String = "FilesImages/" + "\(textFileName).jpeg"
        print("\n============ Uploading files with the SYNC API ============")
        var uploadedFile:BackendlessFile!
        Types.tryblock({ () -> Void in
            let imageData:Data = image.jpegData(compressionQuality: 0.2)!
            uploadedFile = self.backendless.file.uploadFile(filePath,
                                                            content: imageData, overwriteIfExist:true)
            print("File has been uploaded. File URL is - \(uploadedFile!.fileURL ?? "abc")")
        },
                       catchblock: { (exception) -> Void in
                        print("Server reported an error: \(exception as! Fault)")
        })
        return uploadedFile!.fileURL
    }
    func getImage(fromTemplateURL:String) -> UIImage{
        let imageUrlString = fromTemplateURL
        let imageUrl = URL(string: imageUrlString)!
        let imageData = try! Data(contentsOf: imageUrl)
        let image = UIImage(data: imageData)
        return image!
    }
    func addTemplate(template:TemplateModel){
        let newTemplate = template
        templatesArray.append(newTemplate)
        saveTemplate(withTemplate: template)
        print("app enetered added the template")
    }
    func saveTemplate(withTemplate:TemplateModel){
        templatesDataStore.save(withTemplate, response: {
            (withTemplate) -> () in
            print("withTemplate saved")
        },
        error: {
            (fault : Fault?) -> () in
            print("Server reported an error: \(String(describing: fault))")
        })
        print("app saved added the template")

    }
    func retrieveAllTemplates(){
        Types.tryblock({
            let whereClause = "ownerId = '" + (self.currentUser.objectId! as String) + "'"
            let queryBuilder:DataQueryBuilder = DataQueryBuilder()
            queryBuilder.setPageSize(100)
            queryBuilder.setWhereClause(whereClause)
            let result = self.templatesDataStore.find(queryBuilder) as! [TemplateModel]
            self.templatesArray = result
        },
    catchblock: {(exception) -> Void in
        print("Error gettiing scores")
    })
    
    }
    
    func retrieveTemplateById(_ id:String) -> [InvitationModel]{
        var tempalte:[InvitationModel] = []
        Types.tryblock({
            let whereClause = "eventId = '" + id + "'"
            let queryBuilder:DataQueryBuilder = DataQueryBuilder()
            queryBuilder.setWhereClause(whereClause)
            tempalte = self.templatesDataStore.find(queryBuilder) as! [InvitationModel]
        }) { (exception) in
            print(exception.debugDescription)
        }
       
        return tempalte
    }
}
