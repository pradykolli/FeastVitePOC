//
//  HomePageViewController.swift
//  FeastVite
//
//  Created by Student on 6/21/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit
private let reuseIdentifier = "Cell"
class HomePageViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var viewBG: UIView!
    //    @IBOutlet weak var collectionViewVW: UICollectionView!
    var auth:Authentication = Authentication()
    var backendless:Backendless!
    var alerts:AlertErrors = AlertErrors()
    static var templates:[UIImage] = [UIImage(named: "bg")!,UIImage(named: "bg2")!]
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBG.layer.cornerRadius = 15
        backendless = Backendless.sharedInstance()!
        self.navigationItem.setHidesBackButton(true, animated: true)
        let rightBarButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutBTNClicked(_:)))
        navigationItem.rightBarButtonItem = rightBarButton

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print(HomePageViewController.templates.count)
        return HomePageViewController.templates.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TemplateCellCollectionViewCell
        cell.templatePreviewImage.image = HomePageViewController.templates[indexPath.item]
        cell.templateNameLBL.text = "new"
        // Configure the cell
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let rowSize:CGFloat = viewBG.bounds.width
        let heightOfTemplate:CGFloat = CGFloat(185)
        let numberOfColumns = CGFloat(2)
        return CGSize(width: (rowSize / numberOfColumns), height: heightOfTemplate)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
     @objc func logoutBTNClicked(_ sender: UIBarButtonItem){
        backendless.userService.logout({
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let mainHomePage = storyboard.instantiateViewController(withIdentifier: "home") as! UINavigationController
            self.navigationController?.popToRootViewController(animated: true)
        }) { (fault:Fault?) in
            self.alerts.displayAlert("Server Error", (fault?.message)!)
        }
    }
}
