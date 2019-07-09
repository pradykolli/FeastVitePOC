//
//  MailSenderViewController.swift
//  FeastVite
//
//  Created by student on 6/24/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

//Added code to send mails to the users after sending an invite. - Pranathi Mothe

import Foundation
import UIKit
import MessageUI

class MailSenderViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // This function is used to send mail.
    
    @IBAction func sendMailBTN(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }

    }
    
    // This function is used to configure the mail.
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([])
        mailComposerVC.setSubject("You have receieved an invitation from pranureddy0306@gmail.com")
        mailComposerVC.setMessageBody("Hey, I think you don't have FeastVite app to check the invitation. Please download the app by the link given below. ", isHTML: false)
        return mailComposerVC
    }
    // This function is used to send an alert message to the email.
    func showSendMailErrorAlert() {
        
        let alert = UIAlertController(title:"Could Not Send Email", message:"Your device could not send Email.  Please check Email configuration and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Ok", style:.default))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MFMailComposeViewControllerDelegate Method
    private func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismiss(animated: true, completion: nil)
    }
//    static let FCustomURLScheme = "FeastViteCustomUrlScheme://"
//
//        class func openCustomApp() {
//            if openCustomURLScheme(customURLScheme: FCustomURLScheme){
//                // app was opened successfully
//            } else {
//                // handle unable to open the app, perhaps redirect to the App Store
//            }
//        }
//        class func openCustomURLScheme(customURLScheme: String) -> Bool {
//        let customURL = URL(string: customURLScheme)!
//        if UIApplication.shared.canOpenURL(customURL) {
//        if #available(iOS 10.0, *) {
//        UIApplication.shared.open(customURL)
//        } else {
//        UIApplication.shared.openURL(customURL)
//        }
//        return true
//        }
//
//        return false
//        }
    
}



