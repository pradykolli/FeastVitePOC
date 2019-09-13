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
    
    @IBOutlet weak var imagePreview: UIImageView!
    var image:UIImage!
    
    @IBOutlet weak var guestCount: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePreview.image = image
        // Do any additional setup after loading the view.
    }
    

    @IBAction func acceptInvitationBTN(_ sender: Any) {
        
        
    }
    
    
    @IBAction func denyInvitationBTN(_ sender: Any) {
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
