//
//  ChatViewController.swift
//  FeastVitePOC
//
//  Created by pradeep Kolli on 9/9/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendMessageBTN: UIButton!
    @IBOutlet weak var messageTextViewTV: UITextView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTextCell", for: indexPath)
//        let cell2 = tableView.dequeueReusableCell(withIdentifier: "contactsTextCell", for: indexPath)
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
    self.messageTextViewTV.layer.borderWidth = 2
    self.messageTextViewTV.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendActionBTN(_ sender: Any) {
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
