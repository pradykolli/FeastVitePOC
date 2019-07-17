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
    let backendless = Backendless.sharedInstance()!
    var eventObject:EventModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        TemplateModelManager.shared.retrieveAllTemplates()
        EventModelManager.shared.retrieveAllEvents()
        print("total number of templates are: ",TemplateModelManager.shared.templatesArray.count)
        let currentUser : BackendlessUser = backendless.userService.currentUser
        print("Current user",currentUser.objectId!)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        if let sendInvitation = segue.destination as? SendInvitationViewController {
            sendInvitation.eventObj = self.eventObject
        }
    }
 

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return TemplateModelManager.shared.templatesArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Configure the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TemplateCollectionViewCell
        eventObject = EventModelManager.shared.eventsArray[indexPath.item]
        let templateImageURL = TemplateModelManager.shared.templatesArray[indexPath.item].templateImage!
        let templateImage:UIImage = TemplateModelManager.shared.getImage(fromTemplateURL: templateImageURL)
        cell.templatePreviewImage.image = templateImage
        cell.templateNameLBL.text = TemplateModelManager.shared.templatesArray[indexPath.item].templateName
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
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
        self.collectionView.performBatchUpdates({
            self.collectionView.reloadSections(IndexSet(integer: 0))
            collectionView.reloadData()
        }, completion: nil)
        TemplateModelManager.shared.retrieveAllTemplates()
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
