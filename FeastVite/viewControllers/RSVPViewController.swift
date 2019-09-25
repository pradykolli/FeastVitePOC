//
//  RSVPViewController.swift
//  FeastVitePOC
//
//  Created by Student on 9/9/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class RSVPViewController: UIViewController {

    
    
    static let shared = RSVPViewController()
    var eventInvitation:EventModel!
    @IBOutlet weak var imagePreview: UIImageView!
    var image:UIImage!
    
    @IBOutlet weak var guestCount: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePreview.image = nil
        eventInvitation = ViewInvitationsTableViewController.clickedInvitedEvent
        let templateRelatedToEvent = EventModelManager.shared.getTemplate(relatedto: eventInvitation)
        let imageData = templateRelatedToEvent.templateImage
        image = TemplateModelManager.shared.getImage(fromTemplateURL: imageData!)
//        image = TemplateModelManager.shared.getImage(fromTemplateURL:  eventInvitation.eventInviteTemplate.templateImage)
        imagePreview.image = image
        // Do any additional setup after loading the view.
    }
    

    @IBAction func acceptInvitationBTN(_ sender: Any) {
        if guestCount.text == "" {
            print(ERROR.debugDescription)
        }else{
//            let rsvp = Rsvp(guestcount: Int(guestCount.text!)!)
//            RSVPModelManager.shared.save(rsvp)
        }
        
    }
    
    
    @IBAction func denyInvitationBTN(_ sender: Any) {
        let alert = UIAlertController(title: "Deny invitation", message: "Are you sure", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    }
    @IBAction func mayBeInvitaionBTN(_ sender: Any) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
