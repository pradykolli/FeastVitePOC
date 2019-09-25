//
//  ManageTemplatesCollectionViewController.swift
//  FeastVitePOC
//
//  Created by student on 6/13/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ManageTemplatesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let backendless = Backendless.sharedInstance()
    var eventObject:EventModel!
    var dictOfEventTemplate:[EventModel:TemplateModel] = [:]
//    let events:[String] = ["one","two","three"]
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomLoader.instance.hideLoaderView()
        TemplateModelManager.shared.retrieveAllTemplates()
        EventModelManager.shared.retrieveAllEvents()
        for event in EventModelManager.shared.eventsArray{
            dictOfEventTemplate[event] = EventModelManager.shared.getTemplate(relatedto: event)
        }
        print("total number of templates are: ",TemplateModelManager.shared.templatesArray.count)
        let currentUser : BackendlessUser = (backendless?.userService.currentUser)!
        print("Current user",currentUser.objectId!)
        self.navigationItem.leftBarButtonItem = editButtonItem

    }
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @objc func buttonAction(sender: UIButton!) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chatViewController = storyboard.instantiateViewController(withIdentifier: "ChatViewController") 
        self.navigationController?.pushViewController(chatViewController, animated: true)
    }

    @IBAction func deleteBTN(_ sender:Any){
        if let selectedCells = collectionView.indexPathsForSelectedItems {
            print("selected in collection view: " ,selectedCells)
            let items = selectedCells.map { $0.item }.sorted().reversed()
            print(items)
            for item in items {
                print(item)
                let selected = EventModelManager.shared.eventsArray[item]
                let deleteItem = selected.objectId
                EventModelManager.shared.deleteTemplatesOrTemplate(deleteItem!)
                collectionView.reloadData()
            }
            // 3
            collectionView.deleteItems(at: selectedCells)
            deleteButton.isEnabled = false
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        collectionView.allowsMultipleSelection = editing
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            let cell = collectionView.cellForItem(at: indexPath) as! TemplateCollectionViewCell
            cell.isInEditingMode = editing
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // 2
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let selectedItems = collectionView.indexPathsForSelectedItems, selectedItems.count == 0 {
            print(selectedItems.count)
            deleteButton.isEnabled = false
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return EventModelManager.shared.eventsArray.count
//        return events.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Configure the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TemplateCollectionViewCell
        eventObject = EventModelManager.shared.eventsArray[indexPath.item]
        let templateObject:TemplateModel = dictOfEventTemplate[eventObject]!
        let templateImageURL = templateObject.templateImage!
        let templateImage:UIImage = TemplateModelManager.shared.getImage(fromTemplateURL: templateImageURL)
        cell.templatePreviewImage.image = templateImage
        cell.templateNameLBL.text = templateObject.templateName
//        cell.templateNameLBL.text = events[indexPath.row]
        
        cell.isInEditingMode = isEditing
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing {
            deleteButton.isEnabled = false
            print(indexPath.item)
            eventObject = EventModelManager.shared.eventsArray[indexPath.item]
            SendInvitationViewController.eventObj = eventObject
            print("didselect:",eventObject.eventType)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let senderView = storyboard.instantiateViewController(withIdentifier: "SenderView")
            self.navigationController?.pushViewController(senderView, animated: true)
        } else {
            deleteButton.isEnabled = true
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let rowSize:CGFloat = UIScreen.main.bounds.width - 12
        let heightOfTemplate:CGFloat = UIScreen.main.bounds.height - 12
        let numberOfColumns = CGFloat(2)
        let numberOfRows = CGFloat(3)
        return CGSize(width: (rowSize / numberOfColumns), height: heightOfTemplate / numberOfRows)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        TemplateModelManager.shared.retrieveAllTemplates()
        EventModelManager.shared.retrieveAllEvents()
        for event in EventModelManager.shared.eventsArray{
            dictOfEventTemplate[event] = EventModelManager.shared.getTemplate(relatedto: event)
        }
        self.collectionView.performBatchUpdates({
            self.collectionView.reloadSections(IndexSet(integer: 0))
            collectionView.reloadData()
        }, completion: nil)
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
