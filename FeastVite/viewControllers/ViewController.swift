//
//  ViewController.swift
//  FeastVitePOC
//
//  Created by student on 6/13/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var eventLBL: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    InvitationModelManager.shared.retrieveAllContacts()
        eventLBL.text = InvitationModelManager.shared.invitationsArray[0].eventID
    }


}

