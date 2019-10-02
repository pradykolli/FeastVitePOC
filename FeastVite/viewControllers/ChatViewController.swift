//
//  ChatViewController.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 9/9/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var backendless:Backendless = Backendless.sharedInstance()
    var currentUser:BackendlessUser!
    var recieverUser:String!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendMessageBTN: UIButton!
    @IBOutlet weak var messageTextViewTV: UITextView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTextCell", for: indexPath)
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.messageTextViewTV.layer.borderWidth = 2
        self.messageTextViewTV.layer.cornerRadius = 15
        currentUser = backendless.userService.currentUser
    }
    
    @IBAction func sendActionBTN(_ sender: Any) {
        let chat:ChatModel = ChatModel.shared
        chat.message = messageTextViewTV.text!
        chat.senderId = (currentUser.email as String)
        chat.recieverId = recieverUser
        let _ = ChatModelManager.shared.addMessage(chat)
        messageTextViewTV.text = ""
    }

}
