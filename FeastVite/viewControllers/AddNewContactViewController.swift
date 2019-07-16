//
//  AddNewContactViewController.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 7/15/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class AddNewContactViewController: UIViewController {

    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var emailAddressTF: UITextField!
    @IBOutlet weak var contactNameTF: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.cornerRadius = 15
        phoneNumberTF.layer.cornerRadius = 15
        emailAddressTF.layer.cornerRadius = 15
        contactNameTF.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneActionBTN(_ sender: Any) {
        let contact:ContactModel = ContactModel()
        contact.emailAddress = emailAddressTF.text!
        contact.phone = phoneNumberTF.text!
        contact.name = contactNameTF.text!
        ContactModelManager.shared.addContact(contact)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBTN(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
