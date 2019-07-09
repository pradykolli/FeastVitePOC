//
//  SetNewPasswordControllerViewController.swift
//  FeastVite
//
//  Created by Student on 6/20/19.
//  Copyright © 2019 NWMSU. All rights reserved.
//

import UIKit

class SetNewPasswordControllerViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var showHidePassword: UIImageView!
    @IBOutlet weak var showHideConfirmPassword: UIImageView!
    @IBOutlet weak var newPasswordTF: UITextField! // Maintain consistency of labels and textfields. # Srikar Patle
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var skipBTN: UIButton!
    @IBOutlet weak var updatePasswordBTN: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    var backendless:Backendless!
    var email:String?
    var password:String?
    var user: BackendlessUser!
    var alerts:AlertErrors = AlertErrors()
    var auth:Authentication = Authentication()
    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(showPasswordTapped(_:)))
        showHidePassword.addGestureRecognizer(tap)
        showHidePassword.isUserInteractionEnabled = true
        let tapConfirm = UITapGestureRecognizer(target: self, action: #selector(showConfirmPasswordTapped(_:)))
        showHideConfirmPassword.addGestureRecognizer(tapConfirm)
        showHideConfirmPassword.isUserInteractionEnabled = true
        super.viewDidLoad()
        backendless = Backendless.sharedInstance()!
        newPasswordTF.layer.cornerRadius = 15
        confirmPasswordTF.layer.cornerRadius = 15
        self.skipBTN.layer.cornerRadius = 15
        updatePasswordBTN.layer.cornerRadius = 15
        backgroundView.layer.cornerRadius = 15
        newPasswordTF.delegate = self
        confirmPasswordTF.delegate = self
        confirmPasswordTF.returnKeyType = UIReturnKeyType.done
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    //Added function to skip, if the user does not want to create a new password.
    @IBAction func skipBTN(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userHome = storyboard.instantiateViewController(withIdentifier: "homePage") as! HomePageViewController
        self.navigationController?.pushViewController(userHome, animated: true)
        
        
    }
    // Display password when tapped on the show password icon.
    @objc func showPasswordTapped(_ sender: UIImageView){
        if (newPasswordTF.text?.isEmpty)!{
            self.newPasswordTF.isSecureTextEntry = true
        }else{
            if newPasswordTF.isSecureTextEntry{
                self.newPasswordTF.isSecureTextEntry = false
            }else{
                self.newPasswordTF.isSecureTextEntry = true
            }
        }
        
    }
    // Display confirm password when tapped on the show password icon
    @objc func showConfirmPasswordTapped(_ sender: UIImageView){
        if (confirmPasswordTF.text?.isEmpty)!{
            self.confirmPasswordTF.isSecureTextEntry = true
        }else{
            if confirmPasswordTF.isSecureTextEntry{
                self.confirmPasswordTF.isSecureTextEntry = false
            }else{
                self.confirmPasswordTF.isSecureTextEntry = true
            }
        }
        
    }
    /*
    Dispalys error
       1. if the password does not match the requirements or
       2. if the given new password does not match the confirm password
     */
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField{
        case newPasswordTF:
            if !RegistrationViewController.shared.isValidPaasword(strValue: newPasswordTF.text!){
                self.alerts.displayAlert("Password Validation Error", "Minimum 8 and Maximum 16 characters at least 1 Alphabet, 1 Number and 1 Special Character")
            }else{
//                confirmPasswordTF.becomeFirstResponder()
            }
        case confirmPasswordTF:
            if !(newPasswordTF.text?.elementsEqual(confirmPasswordTF.text!))!{
                self.alerts.displayAlert("Password Match Error", "Passwords should be same")
            }
            
        default:
            newPasswordTF.becomeFirstResponder()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == newPasswordTF{
            confirmPasswordTF.becomeFirstResponder()
        }
        else if textField == confirmPasswordTF{
            confirmPasswordTF.resignFirstResponder()
        }
        return true
    }
    // This function is used to save the password.

    @IBAction func savePasswordBTN(_ sender: Any) {

        if (newPasswordTF.text?.elementsEqual(confirmPasswordTF.text!))!{

            let properties = [
                "password" : newPasswordTF.text
            ]
            user.updateProperties(properties as [String : Any])
            self.backendless.userService.update(user, response: { (updatedUser: BackendlessUser!) -> () in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let userHome = storyboard.instantiateViewController(withIdentifier: "homePage") as! HomePageViewController
                self.navigationController?.pushViewController(userHome, animated: true)
            }, error: { (fault:Fault?) in
                self.alerts.displayAlert("Server Error", (fault?.message)!)
            })
        if (newPasswordTF.text?.elementsEqual(confirmPasswordTF.text!))!{
        }
        else{
           self.alerts.displayAlert("password Match Error", "Passwords should be same")
        }
    }
    
}
}

