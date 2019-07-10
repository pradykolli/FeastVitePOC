//
//  ResetPasswordViewController.swift
//  FeastVite
//
//  Created by student on 6/14/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var showHidePassword: UIImageView!
    var loginController:LoginViewController!
    @IBOutlet weak var tempPasswordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var verifyBTN: UIButton!
    var alertErrors:AlertErrors = AlertErrors()
    var email:String!
    var backendless:Backendless!
    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(showPasswordTapped(_:)))
        showHidePassword.addGestureRecognizer(tap)
        showHidePassword.isUserInteractionEnabled = true
        super.viewDidLoad()
        backendless = Backendless.sharedInstance()
        navigationItem.title = "Reset Password"
        emailTF.text = email
        emailTF.isEnabled = false
        backgroundView.layer.cornerRadius = 15
        tempPasswordTF.layer.cornerRadius = 15
        emailTF.layer.cornerRadius = 15
        verifyBTN.layer.cornerRadius = 15
        tempPasswordTF.returnKeyType = UIReturnKeyType.done
        self.hideKeyboardWhenTappedAround()
    }
    
    
    /* Password Reset, and it will send the temparory password to registerd user from backendless
    */
    
    @IBAction func verifyPasswordBTN(_ sender: Any) {
        if  (tempPasswordTF.text?.isEmpty)!{
           self.alertErrors.displayAlert("password is mandatory", "Please enter the temporary password for login")
        }
        else{
            backendless.userService!.login(emailTF.text, password: tempPasswordTF.text, response: { (user) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let setNewPasswordController = storyboard.instantiateViewController(withIdentifier: "new Password") as! SetNewPasswordControllerViewController
                self.navigationController?.pushViewController(setNewPasswordController, animated: true)
                 let usermail = self.backendless.userService.currentUser
                setNewPasswordController.user = usermail!
                
            }, error: { (fault:Fault?) in
                self.alertErrors.displayAlert("Something is worng", (fault?.message)!)
            })
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tempPasswordTF{
            tempPasswordTF.resignFirstResponder()
        }
        return true
    }
   // added functionality to display password, if needed by the user.
    @objc func showPasswordTapped(_ sender: UIImageView){
        if (tempPasswordTF.text?.isEmpty)!{
            self.tempPasswordTF.isSecureTextEntry = true
        }else{
            if tempPasswordTF.isSecureTextEntry{
                self.tempPasswordTF.isSecureTextEntry = false
            }else{
                self.tempPasswordTF.isSecureTextEntry = true
            }
        }
        
    }
  
}
